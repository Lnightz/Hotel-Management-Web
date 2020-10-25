﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.Models;
using Microsoft.Ajax.Utilities;
using System.Data.Entity;
using HOTELMANAGEWEB.DTO;

namespace HOTELMANAGEWEB.Areas.Manage.Controllers
{
    public class ManageController : Controller
    {
        // GET: Manage/Manage
        public ActionResult Index()
        {
            return View();
        }

        [ActionName("Manage-19")]
        public ActionResult ManageRoom()
        {
            ViewBag.maxFloor = ManageRoomBLL.Instance.GetMaxFloor();

            return View();
        }

        [ChildActionOnly]
        public PartialViewResult RoomModal(int id)
        {
            var roominfo = ManageRoomBLL.Instance.GetRoomByID(id);
            ViewBag.Roominfo = roominfo;

            ViewBag.billID = InvoicesBLL.Instance.GetBillIDByRoomID(id);

            if (roominfo.RoomStatus == "BOOKING" || roominfo.RoomStatus == "RENTED")
            {
                var bookingid = ManageRoomBLL.Instance.GetBookingbyRoomID(id);
                var bookinfo = BookingRoomBLL.Instance.GetBookingbyID(bookingid.BookingID);

                ViewBag.BookingInfo = bookinfo;

            }
            return PartialView("");
        }

        public PartialViewResult CreateRoom()
        {
            return PartialView(ManageRoomBLL.Instance.GetRoomTypesList());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateRoom(Room model)
        {
            var user = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
            using (var db = new QLKSWEBEntities())
            {
                Room room = new Room()
                {
                    RoomName = model.RoomName,
                    RoomStatus = "OPEN",
                    MinQuantity = model.MinQuantity,
                    MaxQuantity = model.MaxQuantity,
                    RoomTypeID = model.RoomTypeID,
                    DateCreated = DateTime.Now,
                    CreatedUserID = user.AccountID
                };
                db.Rooms.Add(room);
                db.SaveChanges();
            }
            return RedirectToAction("Manage-19");
        }

        [ActionName("Manage-27")]
        public ActionResult ManageServices()
        {
            if (TempData["DataResult"] != null)
            {
                ViewBag.Message = TempData["DataResult"].ToString();
            }
            ViewBag.ListServType = ManageBLL.Instance.GetListServType();
            ViewBag.ListServ = ManageBLL.Instance.GetServices();
            return View();
        }

        [HttpGet]
        public PartialViewResult AddEditServModal(int? id)
        {
            ViewBag.ListServType = ManageBLL.Instance.GetListServType();
            ViewBag.ServID = id;
            var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
            ViewBag.UserID = account.AccountID;
            ViewBag.Services = ManageBLL.Instance.GetServicesbyID(id);
            return PartialView();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddServ(Service model)
        {
            var result = ManageBLL.Instance.AddServs(model);
            if (result == 1)
            {
                TempData["DataResult"] = "SAVE";
                return RedirectToAction("Manage-27", "Manage");
            }
            else
            {
                TempData["DataResult"] = "SAVEFAIL";
                return RedirectToAction("Manage-27", "Manage");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditServ(Service model)
        {
            var serv = ManageBLL.Instance.UpdateServ(model);
            if (serv > 0)
            {
                TempData["EDITSERV"] = "SUCCESS";
                return RedirectToAction("Manage-27");
            }
            TempData["EDITSERV"] = "FAIL";
            return RedirectToAction("Manage-27");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteServ(int id)
        {
            var result = ManageBLL.Instance.DeleteServ(id);
            if (result == 1)
            {
                TempData["DataResult"] = "DELETED";
                return RedirectToAction("Manage-27", "Manage");
            }
            else
            {
                TempData["DataResult"] = "DELETEDFAIL";
                return RedirectToAction("Manage-27", "Manage");
            }
        }

        [ActionName("Manage-35")]
        public ActionResult ManageBookingRoom()
        {
            if (TempData["ChoseRoomStatus"] != null)
            {
                ViewBag.Message = TempData["ChoseRoomStatus"].ToString();
            }
            ViewBag.ListBookingRoom = BookingRoomBLL.Instance.GetListBooking();
            return View();
        }

        [ChildActionOnly]
        public PartialViewResult ChoseRoomForBooking(int id, int roomtypeid)
        {
            ViewBag.ListRoomOpen = BookingRoomBLL.Instance.GetRoomOpenWithTypeID(roomtypeid);
            ViewBag.BookingID = id;
            Session["BookingID"] = id;
            return PartialView();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult BookRoomChose(Room room)
        {
            using (var db = new QLKSWEBEntities())
            {
                int bookingid = (int)Session["BookingID"];
                Room choseroom = ManageRoomBLL.Instance.GetRoomByID(room.RoomID);
                choseroom.RoomStatus = "BOOKING";
                db.Entry(choseroom).State = EntityState.Modified;
                // ở cái đoạn này viết vậy là nó chỉ update đúng 1 bảng Room thôi đúng không?
                // đúng rồi, nó chỉ affect Room thôi
                // nhưng sao tui bị lỗi này nhỉ, tui demo ông xem
                if (db.SaveChanges() > 0)
                {
                    //Booking bookingvoucher = BookingRoomBLL.Instance.GetBookingbyID(bookingid);
                    Booking bookingvoucher = db.Bookings.Find(bookingid);
                    bookingvoucher.BookingStatus = "BOOKING";
                    db.Entry(bookingvoucher).State = EntityState.Modified;
                    if (db.SaveChanges() > 0)
                    {
                        BookingRoom booking = new BookingRoom()
                        {
                            RoomID = room.RoomID,
                            BookingID = bookingid,
                            IsBooking = 1
                        };
                        db.BookingRooms.Add(booking);
                        if (db.SaveChanges() > 0)
                        {
                            TempData["ChoseRoomStatus"] = "BOOKSUCCES";
                            return RedirectToAction("Manage-35");
                        }
                    }
                }
                
                TempData["ChoseRoomStatus"] = "BOOKFAIL";
                return RedirectToAction("Manage-35");
            }
        }
        public PartialViewResult AddEditBooking(int id)
        {
            ViewBag.ListRoomOpen = BookingRoomBLL.Instance.GetRoomOpenWithTypeID(null);
            ViewBag.BookingID = id;
            var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
            ViewBag.UserID = account.AccountID;
            ViewBag.BookingInfo = BookingRoomBLL.Instance.GetBookingbyID(id);
            return PartialView();
        }

        public PartialViewResult AddBooking()
        {
            ViewBag.ListRoomOpen = BookingRoomBLL.Instance.GetRoomOpenWithTypeID(null);
            var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
            ViewBag.UserID = account.AccountID;
            return PartialView();
        }

        public ActionResult RentRoom(int bookingid, int roomid)
        {
            var bookinginfo = BookingRoomBLL.Instance.GetBookingbyID(bookingid);
            var user = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
            using (var db = new QLKSWEBEntities())
            {
                Bill bill = new Bill()
                {
                    CheckinDate = DateTime.Now,
                    BillStatus = "OPEN",
                    CreatedUserID = user.AccountID,
                    DateCreated = DateTime.Now
                };
                db.Bills.Add(bill);
                if (db.SaveChanges() > 0)
                {
                    var room = db.Rooms.Find(roomid);
                    room.RoomStatus = "RENTED";
                    db.SaveChanges();
                    var booking = db.Bookings.Find(bookingid);
                    booking.BookingStatus = "DONE";
                    db.SaveChanges();
                    foreach (var item in bookinginfo.BookingServices)
                    {
                        BillDetail billDetail = new BillDetail()
                        {
                            BillID = bill.BillID,
                            ServicesID = item.ServicesID,
                            RoomID  = roomid,
                            Quantity = 1,
                            TotalSerivcesPrices = item.Service.ServicesPrices
                        };
                        db.BillDetails.Add(billDetail);
                        db.SaveChanges();
                    }
                    return RedirectToAction("Manage-19");
                }
                return RedirectToAction("Manage-19");
            }
        }

        [ActionName("Manage-23")]
        public ActionResult ManageInvoice()
        {
            var listBill = InvoicesBLL.Instance.GetListBill();
            ViewBag.ListBill = listBill;
            return View();
        }

        public ActionResult InvoiceDetail(int id)
        {
            var details = InvoicesBLL.Instance.GetBillDetailByID(id);
            var listServ = InvoicesBLL.Instance.GetServicesInBillDetailByID(id);
            var totalServ = InvoicesBLL.Instance.GetSumTotalServicesById(id);
            ViewBag.ListServ = listServ;
            ViewBag.Details = details;
            ViewBag.TotalServ = totalServ;
            return View();
        }

        public PartialViewResult AddServToBill(int id)
        {
            ViewBag.ID = id;
            ViewBag.ListServ = ManageBLL.Instance.GetServices();
            return PartialView();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddServtoBill(BillDetail detail)
        {
            using (var db = new QLKSWEBEntities())
            {
                var prices = db.Services.Where(x => x.ServicesID == detail.ServicesID).FirstOrDefault();
                var room = db.BillDetails.Where(x => x.BillID == detail.BillID).FirstOrDefault();
                BillDetail billDetail = new BillDetail()
                {
                    ServicesID = detail.ServicesID,
                    BillID = detail.BillID,
                    Quantity = detail.Quantity,
                    RoomID = room.RoomID,
                    TotalSerivcesPrices = detail.Quantity * prices.ServicesPrices
                };
                db.BillDetails.Add(billDetail);
                if (db.SaveChanges() > 0)
                {
                    return RedirectToAction("InvoiceDetail", new { id = detail.BillID });
                }
            }
            TempData["AddServToBillResult"] = "FAIL";
            return RedirectToAction("InvoiceDetail", new { id = detail.BillID });
        }

        [ActionName("Manage-31")]
        public ActionResult ManageAccount()
        {
            if (TempData["CREATERESULT"] != null)
            {
                ViewBag.Message = TempData["CREATERESULT"].ToString();
            }
            var listaccount = AccountBLL.Instance.GetListAccount();
            return View(listaccount);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LockUser(int id)
        {
            var result = AccountBLL.Instance.LockUser(id);
            if (result == 1)
            {
                TempData["LockResult"] = "SUCCESS";
                return RedirectToAction("Manage-31");
            }
            TempData["LockResult"] = "FAIL";
            return RedirectToAction("Manage-31");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult UnlockUser(int id)
        {
            var result = AccountBLL.Instance.UnlockUser(id);
            if (result == 1)
            {
                TempData["UNLOCK"] = "SUCCESS";
                return RedirectToAction("Manage-31");
            }
            TempData["UNLOCK"] = "FAIL";
            return RedirectToAction("Manage-31");
        }

        public PartialViewResult CreateAccount()
        {
            return PartialView(AccountBLL.Instance.GetListAccountTypes());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateAccount(Account account)
        {
            var result = AccountBLL.Instance.CreateAccount(account);
            if (result == -2)
            {
                TempData["CREATERESULT"] = "CREATEFAIL";
                return RedirectToAction("Manage-31");
            }
            return RedirectToAction("Manage-31");
        }


        public PartialViewResult AddPermission(int id)
        {
            ViewBag.ID = id;
            ViewBag.ListModule = AccountBLL.Instance.GetUserPerMission(id);
            ViewBag.AllModule = ManageBLL.Instance.GetModulesList();
            return PartialView();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddPermission(AccountPermission permission)
        {
            var result = AccountBLL.Instance.AddPermission(permission);
            return RedirectToAction("Manage-31");
        }

        public PartialViewResult RemovePermission(int id)
        {
            ViewBag.ID = id;
            ViewBag.ListModule = AccountBLL.Instance.GetUserPerMission(id);
            return PartialView();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RemovePermission(AccountPermission permission)
        {
            var result = AccountBLL.Instance.RemovePermission(permission);
            return RedirectToAction("Manage-31");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ResetPassword(int id)
        {
            var result = AccountBLL.Instance.Resetpass(id);
            if (result == 1)
            {
                TempData["ResetPass"] = "SUCCESS";
                return RedirectToAction("Manage-31");
            }
            TempData["ResetPass"] = "FAIL";
            return RedirectToAction("Manage-31");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Paid(Bill model)
        {
            var account = ManageBLL.Instance.GetUserByUserName(User.Identity.Name);
            using (var db = new QLKSWEBEntities())
            {
                var details = db.BillDetails.Where(x => x.BillID == model.BillID).FirstOrDefault();
                var room = db.Rooms.Where(x => x.RoomID == details.RoomID).FirstOrDefault();
                room.RoomStatus = "OPEN";
                db.SaveChanges();

                Bill bill = db.Bills.Where(x => x.BillID == model.BillID).FirstOrDefault();
                bill.BillStatus = "PAID";
                bill.Total = model.Total;
                bill.CheckoutDate = DateTime.Now;
                bill.DateModify = DateTime.Now;
                db.SaveChanges();
            }
            return RedirectToAction("Manage-23");
        }


        [ActionName("Manage-43")]
        public ActionResult ManageEquipments()
        {
            return View();
        }

        [ActionName("Manage-51")]
        public ActionResult ManageCategory()
        {
            return View();
        }

        [ActionName("Manage-55")]
        public ActionResult ManagePromotions()
        {
            return View();
        }

        [ActionName("Manage-47")]
        public ActionResult ManageRequest()
        {
            return View(RequestBLL.Instance.GetRequests());
        }

        public PartialViewResult ChangePass()
        {
            return PartialView();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePass(ChangePassModel model)
        {
            var result = AccountBLL.Instance.ChangePassword(User.Identity.Name, model);
            return RedirectToAction("Index", "ListModule");
        }

        [ActionName("Manage-59")]
        public ActionResult Chart()
        {
            return View();
        }

        public PartialViewResult CreateRequest()
        {
            ViewBag.ListType = RequestBLL.Instance.GetRequestTypes();
            ViewBag.ListEquip = RequestBLL.Instance.GetEquipment();
            return PartialView();
        }

        public ActionResult CancelBooking(int bookingid)
        {
            using (var db = new QLKSWEBEntities())
            {
                var booking = BookingRoomBLL.Instance.GetBookingbyID(bookingid);
                booking.BookingStatus = "CANCEL";
                db.SaveChanges();
                var roomid = ManageRoomBLL.Instance.GetRoomIDByBookingID(bookingid);
                var room = ManageRoomBLL.Instance.GetRoomByID(roomid);
                room.RoomStatus = "OPEN";
                db.SaveChanges();
            }
            return View("Manage-19");
        }
    }
}
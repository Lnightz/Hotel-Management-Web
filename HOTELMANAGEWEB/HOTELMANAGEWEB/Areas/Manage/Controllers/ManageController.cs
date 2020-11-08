using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.Models;
using Microsoft.Ajax.Utilities;
using System.Data.Entity;
using HOTELMANAGEWEB.DTO;
using System.Security.Cryptography;

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
            if (TempData["ChangeRoom"] != null)
            {
                ViewBag.Message = TempData["ChangeRoom"].ToString();
            }

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
            if (result != null)
            {
                TempData["ChangePass"] = "SUCCESS";
                return RedirectToAction("Index", "ListModule");
            }
            TempData["ChangePass"] = "FAIL";
            return RedirectToAction("Index", "ListModule");
        }

        [ActionName("Manage-59")]
        public ActionResult Chart()
        {
            ViewBag.NewCus = ReportBLL.Instance.GetNewCustomer();
            ViewBag.MaintenanceRoom = ReportBLL.Instance.GetMaintenaceRoom();
            ViewBag.RentRoom = ReportBLL.Instance.GetRentedRoom();
            ViewBag.Total = ReportBLL.Instance.GetTotal();
            ViewBag.Booking = ReportBLL.Instance.TotalBooking();
            ViewBag.CancelBooking = ReportBLL.Instance.TotalCancelBooking();
            ViewBag.TotalServices = ReportBLL.Instance.GetTotalServices();
            ViewBag.TotalRoom = ReportBLL.Instance.GetTotalRoom();

            int month = DateTime.Now.Month;
            int year = DateTime.Now.Year;

            var PieChart = ReportBLL.Instance.pieChartModels(month, year);

            ViewBag.PieChartRoomTypeName = (from temp in PieChart select temp.RoomTypeName).ToList();
            ViewBag.PieChartQuantity = (from temp in PieChart select temp.Quantity).ToList();

            var SalesChart = ReportBLL.Instance.salesChartModels(month, year);

            var SalesChartDay = (from temp in SalesChart select temp.Day.ToString("yyyy-MM-dd")).ToList();

            string SalesChartDay_temp = string.Join(" , ", SalesChartDay);

            ViewBag.SalesChartDay = SalesChartDay_temp.Trim();

            ViewBag.SalesChartRevenue = (from temp in SalesChart select temp.TotalRoomRevenue).ToList();


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

        [HttpGet]
        public ActionResult ChangeRoom(int? BillID, int? BookingID)
        {
            if (BillID != null)
            {
                var roomid = InvoicesBLL.Instance.GetRoomIDByBillID(BillID);
                ViewBag.RoomID = roomid;
            }
            if (BookingID != null)
            {
                var roomid = ManageRoomBLL.Instance.GetRoomIDByBookingID(BookingID);
                ViewBag.RoomID = roomid;
            }
            ViewBag.BillID = BillID;
            ViewBag.BookingID = BookingID;
            ViewBag.ListOpenRoom = ManageRoomBLL.Instance.GetListOpenRoom();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangeRoom(int? BillID, int RoomID, int RoomChangeID, int? BookingID)
        {
            int result = ManageRoomBLL.Instance.ChangeRoom(BillID, RoomID, RoomChangeID, BookingID);
            if (result == 1)
            {
                TempData["ChangeRoom"] = "CHANGESUCCESS";
                return RedirectToAction("Manage-19");
            }
            TempData["ChangeRoom"] = "CHANGEFAIL";
            return RedirectToAction("Manage-19");
        }

        public PartialViewResult CheckRoomIsUsed(int RequestID)
        {
            var result = RequestBLL.Instance.CheckRoomIsUsed(RequestID);
            ViewBag.RequestID = RequestID;
            if (result == true)
            {
                ViewBag.Mode = 1; //Phòng đang được sử dụng
                return PartialView();
            }
            ViewBag.Mode = 0; // Phòng đang trống
            return PartialView();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ApproveRequest(int RequestID, int mode)
        {
            var room = ManageRoomBLL.Instance.GetRoomByRequestID(RequestID);
            using (var db = new QLKSWEBEntities())
            {
                var request = db.Requests.Find(RequestID);
                var result = RequestBLL.Instance.ApproveRequest(RequestID);
                if (result != null)
                {
                    var equip = db.Equipments.Find(request.EquipmentID);
                    equip.EquipStatus = 1;
                    if (mode == 1) // Bảo trì phòng cùng thiết bị
                    {
                        room.RoomStatus = "MAINTENANCE";
                    }
                    db.SaveChanges();
                    return RedirectToAction("Manage-47");
                }
                return RedirectToAction("Manage-47");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DenyRequest(int RequestID)
        {
            var result = RequestBLL.Instance.DenyRequest(RequestID);
            if (result != null)
            {
                TempData["Request"] = "DENIEDSUCCESS";
                return RedirectToAction("Manage-47");
            }
            TempData["Request"] = "DENIEDFAIL";
            return RedirectToAction("Manage-47");
        }

        public ActionResult EquipFinishMantenance(int id)
        {
            var result = ManageBLL.Instance.FinishMaintenance(id);
            if (result != null)
            {
                return View("Manage-43");
            }
            return View("Manage-43");
        }

        public ActionResult RoomFinishMantenace(int id)
        {
            var result = ManageRoomBLL.Instance.RoomFinishMaintenance(id);
            if (result != null)
            {
                return View("Manage-19");
            }
            return View("Manage-19");
        }
    }
}

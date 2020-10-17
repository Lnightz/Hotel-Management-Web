using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.DTO;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace HOTELMANAGEWEB.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.IndexActive = "active";
            return View();
        }

        public ActionResult About()
        {
            ViewBag.AboutActive = "active";
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.ContactActive = "active";
            return View();
        }
        public ActionResult Blog()
        {
            ViewBag.BlogActive = "active";
            return View();
        }
        public ActionResult Amenities()
        {
            ViewBag.AmenitiesActive = "active";
            return View();
        }
        public ActionResult DiningBar()
        {
            ViewBag.DiningBarActive = "active";
            return View();
        }
        public ActionResult Room()
        {

            ViewBag.RoomActive = "active";
            return View();
        }
        public ActionResult BlogDetail(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ViewBag.BlogActive = "active";
            return View();
        }
        public ActionResult Reservation()
        {
            ViewBag.ReservationActive = "active";
            return View();
        }

        public ActionResult RoomDetails()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CheckAvailableRooms(CheckAvailableRooms model)
        {

            var availablerooms = HomeBLL.Instance.AvailableRooms(model);
            if (model.CheckDateNull != 1)
            {
                if (model.CheckDateNull == -1)
                {
                    ViewBag.Message = "CHECKINNULL";
                    return View("Index");
                }
                else if (model.CheckDateNull == -2)
                {
                    ViewBag.Message = "CHECKOUTNULL";
                    return View("Index");
                }
                else if (model.CheckDateNull == -3)
                {
                    ViewBag.Message = "ALLNULL";
                    return View("Index");
                }
            }

            if (model.CompareDate == -1)
            {
                ViewBag.Message = "COMPAREDATE";
                return View("Index");
            }

            if (availablerooms == null)
            {
                ViewBag.Message = "FAIL";
                return View();
            }
            else
            {
                TempData["BookingInfor"] = model;
                ViewBag.AvailableRoomList = availablerooms;
                return View();
            }
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult BookingServWithRoom(int RoomTypeID)
        {
            //ViewBag.ListServ = HomeBLL.Instance.BookServWithRoom();
            //var ListServ = HomeBLL.Instance.BookServWithRoom();

            var ListServ = new ServicesModel();

            using (var db = new QLKSWEBEntities())
            {
                ListServ.Services = db
                    .Services
                    .Where(x => x.IsBookWithRoom == 1 && x.IsAvailable == 0)
                    .ToList<Service>();
            }

            TempData["RoomTypeID"] = RoomTypeID;
            return View(ListServ);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ConfirmInfo(ServicesModel serv)
        {
            var db = new QLKSWEBEntities();

            var selectedserv = serv.Services.Where(x => x.IsSelected == true).ToList<Service>();

            var Listserv = Session["AddServ"];

            Session["AddServ"] = selectedserv;

            if (TempData["RoomTypeID"] != null && TempData["BookingInfor"] != null)
            {
                var roomtypeID = TempData["RoomTypeID"];

                ViewBag.BookingInfo = TempData["BookingInfor"];

                ViewBag.RoomType = ManageRoomBLL.Instance.GetRoomTypeByID((int)roomtypeID);
            }

            if (TempData["BookingResult"] != null)
            {
                ViewBag.BookingResult = TempData["BookingResult"].ToString();
            }

            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult BookingRoom(Customer customer)
        {
            var checkcustomer = BookingRoomBLL.Instance.CheckCustomerInfo(customer.Passport);

            if (checkcustomer == -1)
            {
                using (var db = new QLKSWEBEntities())
                {
                    Customer cus = new Customer()
                    {
                        CustomerName = customer.CustomerName,
                        Email = customer.Email,
                        Phone = customer.Phone,
                        Passport = customer.Passport,
                        BirthDay = customer.BirthDay,
                        CardType = customer.CardType,
                        CardNo = customer.CardNo,
                        NameOnCard = customer.NameOnCard,
                        ExpirationDate = customer.ExpirationDate,
                    };
                    db.Customers.Add(cus);
                    if (db.SaveChanges() < 0)
                    {
                        TempData["BookingResult"] = "FAIL";
                        return RedirectToAction("ConfirmInfo");
                    }
                }
            }
            else if (checkcustomer == 1)
            {
                Customer oldcus = BookingRoomBLL.Instance.GetCustomerByPassport(customer.Passport);
                using (var db = new QLKSWEBEntities())
                {
                    oldcus.CustomerName = customer.CustomerName;
                    oldcus.CustomerName = customer.CustomerName;
                    oldcus.Email = customer.Email;
                    oldcus.Phone = customer.Phone;
                    oldcus.BirthDay = customer.BirthDay;
                    oldcus.CardType = customer.CardType;
                    oldcus.CardNo = customer.CardNo;
                    oldcus.NameOnCard = customer.NameOnCard;
                    oldcus.ExpirationDate = customer.ExpirationDate;
                    if (db.SaveChanges() < 0)
                    {
                        TempData["BookingResult"] = "FAIL";
                        return RedirectToAction("ConfirmInfo");
                    }
                }
            }

            var roomtypeid = TempData["RoomTypeID"];

            var bookinfo = (CheckAvailableRooms)TempData["BookingInfor"];

            var listServ = (List<Service>)Session["AddServ"];

            Customer cusinfo = BookingRoomBLL.Instance.GetCustomerByPassport(customer.Passport);

            using (var db = new QLKSWEBEntities())
            {
                Booking booking = new Booking()
                {
                    BookDate = DateTime.Now,
                    CheckinDate = bookinfo.CheckinDate,
                    CheckoutDate = bookinfo.CheckoutDate,
                    BookingType = "ROOM",
                    BookingStatus = "OPEN",
                    RoomTypeID = (int)roomtypeid,
                    CustomerID = cusinfo.CustomerID,
                    DateCreated = DateTime.Now,
                };
                db.Bookings.Add(booking);
                if (db.SaveChanges() > 0)
                {
                    foreach (var item in listServ)
                    {
                        BookingService bookserv = new BookingService()
                        {
                            BookingID = booking.BookingID,
                            ServicesID = item.ServicesID,
                        };
                        db.BookingServices.Add(bookserv);
                        if (db.SaveChanges() < 0)
                        {
                            TempData["BookingResult"] = "FAIL";
                            return RedirectToAction("ConfirmInfo");
                        }
                    }
                    TempData["BookingResult"] = "SUCCESS";
                    return RedirectToAction("ConfirmInfo");
                }
                TempData["BookingResult"] = "FAIL";
                return RedirectToAction("ConfirmInfo");
            }
        }

        public ActionResult CancelBooking()
        {
            Session.Remove("AddServ");
            TempData.Remove("RoomTypeID");
            TempData.Remove("BookingInfor");
            return RedirectToAction("Index");
        }
    }
}
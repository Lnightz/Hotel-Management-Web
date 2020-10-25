using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.DTO;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
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
            Session.Clear();
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
            return View(ManageRoomBLL.Instance.GetRoomTypesList());
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

            if (availablerooms.Count() == 0)
            {
                TempData["BookingResult"] = "NOAVAILABLE";
                return View("BookingRoom");
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
                    .Where(x => x.IsBookWithRoom == true && x.IsAvailable == false)
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

                Session["RoomTypeID"] = roomtypeID;

                ViewBag.BookingInfo = TempData["BookingInfor"];

                Session["BookingInfo"] = ViewBag.BookingInfo;
                ViewBag.RoomType = ManageRoomBLL.Instance.GetRoomTypeByID((int)roomtypeID);
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
                        return View();
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
                    db.Entry(oldcus).State = EntityState.Modified;
                    if (db.SaveChanges() < 0)
                    {
                        TempData["BookingResult"] = "FAIL";
                        return View();
                    }
                }
            }

            var roomtypeid = Session["RoomTypeID"];

            var bookinfo = (CheckAvailableRooms)Session["BookingInfo"];

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
                            Quantity = 1
                        };
                        db.BookingServices.Add(bookserv);
                        if (db.SaveChanges() < 0)
                        {
                            TempData["BookingResult"] = "FAIL";
                            return View();
                        }
                    }
                    Session.Clear();
                    TempData["BookingResult"] = "SUCCESS";
                    return View();
                }
                TempData["BookingResult"] = "FAIL";
                return View();
            }
        }

        public ActionResult CancelBooking()
        {
            Session.Clear();
            TempData.Clear();
            return RedirectToAction("Index");
        }
    }
}
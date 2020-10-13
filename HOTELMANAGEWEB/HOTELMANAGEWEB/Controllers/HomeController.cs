using HOTELMANAGEWEB.BLL;
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

        public ActionResult CheckAvailable(int? PersonNumber, DateTime? CheckinDate, DateTime? CheckoutDate)
        {
            var availablerooms = HomeBLL.Instance.AvailableRooms(PersonNumber, CheckinDate, CheckoutDate);
            if (availablerooms == null)
            {
                ViewBag.Message = "FAIL"; 
                return View();
            }
            else
            {
                return View();
            }
        }
    }
}
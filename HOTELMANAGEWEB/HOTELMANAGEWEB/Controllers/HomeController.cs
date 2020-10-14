using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.DAL;
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
            if(model.CheckDateNull != 1)
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

            if(model.CompareDate == -1)
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
                ViewBag.AvailableRoomList = availablerooms;
                return View();
            }
        }
    }
}
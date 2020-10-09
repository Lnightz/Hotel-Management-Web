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
            return View();
        }

        public ActionResult About()
        {        
            return View();
        }

        public ActionResult Contact()
        {
            return View();
        }
        public ActionResult Blog()
        {
            return View();
        }
        public ActionResult Amenities()
        {
            return View();
        }
        public ActionResult DiningBar()
        {
            return View();
        }
        public ActionResult Room()
        {
            return View();
        }
        public ActionResult BlogDetail(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            return View();
        }
        public ActionResult Reservation()
        {
            return View();
        }
    }
}
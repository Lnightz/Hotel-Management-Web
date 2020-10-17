using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.Models;
using Microsoft.Ajax.Utilities;

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
        public ActionResult RoomModal(int id)
        {
            ViewBag.RoomID = id;
            return PartialView("");
        }
        [ActionName("Manage-27")]
        public ActionResult ManageServices()
        {
            if ( TempData["DataResult"] != null)
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
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteServ (int id)
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
            ViewBag.ListBookingRoom = BookingRoomBLL.Instance.GetListBooking();
            return View();
        }

        public PartialViewResult AddEditBookingRoom()
        {
            return PartialView();
        }


        public ActionResult ManageInvoice()
        {
            return View();
        }
        [ActionName("Manage-31")]
        public ActionResult ManageAccount()
        {
            return View();
        }
        [ActionName("Manage-51")]
        public ActionResult ManageCategory()
        {
            return View();
        }

        public ActionResult ManageNews()
        {
            return View();
        }

        public ActionResult ManageEquip()
        {
            return View();
        }

        public ActionResult ManageRequest()
        {
            return View();
        }
    }
}
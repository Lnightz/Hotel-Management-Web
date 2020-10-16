using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.BLL;
using HOTELMANAGEWEB.Models;

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
        public ActionResult AddServ(Services model)
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
        public ActionResult EditServ(Services model)
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

    }
}
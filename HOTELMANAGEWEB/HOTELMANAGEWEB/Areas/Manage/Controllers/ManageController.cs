using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.BLL;

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
    }
}
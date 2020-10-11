using HOTELMANAGEWEB.DAL;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HOTELMANAGEWEB.Areas.Manage.Controllers
{
    public class ListModuleController : Controller
    {
        QLKSWEBEntities db = new QLKSWEBEntities();
        // GET: Manage/ListModule
        public ActionResult Index()
        {
            var infor = db.Get_Module(User.Identity.Name).ToList();

            return View(infor);
        }

        public ActionResult Module(int? id)
        {
            string actionName = string.Format("Manage-{0}", id);
            return RedirectToAction(actionName, "Manage");
        }
    }
}
using HOTELMANAGEWEB.DAL;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using HOTELMANAGEWEB.BLL;

namespace HOTELMANAGEWEB.Areas.Manage.Controllers
{
    public class ListModuleController : Controller
    {

        // GET: Manage/ListModule
        public ActionResult Index()
        {

            if (TempData["ChangePass"] != null)
            {
                ViewBag.Message = TempData["ChangePass"].ToString();
            }

            var infor = ManageBLL.Instance.GetModules(User.Identity.Name);

            return View(infor);
        }

        public ActionResult Module(int? id)
        {
            string actionName = string.Format("Manage-{0}", id);
            return RedirectToAction(actionName, "Manage");
        }

        public PartialViewResult ListModule()
        {
            return PartialView(ManageBLL.Instance.GetModules(User.Identity.Name));
        }
    }
}
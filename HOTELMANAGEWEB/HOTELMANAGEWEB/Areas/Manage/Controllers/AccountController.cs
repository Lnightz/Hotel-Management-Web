using HOTELMANAGEWEB.DAL;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace HOTELMANAGEWEB.Areas.Manage.Controllers
{
    public class AccountController : Controller
    {
        QLKSWEBEntities db = new QLKSWEBEntities();


        public void Authencicate(Account user)
        {
            ///Setup lưu cookies người dùng
            FormsAuthentication.SetAuthCookie(user.UserName, false);

            var authTicket = new FormsAuthenticationTicket(1,
                user.UserName,
                DateTime.Now,
                DateTime.Now.AddMinutes(30),
                false,
                user.AccountType.AccountTypeName);

            string encryptedTicket = FormsAuthentication.Encrypt(authTicket);

            var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);

            HttpContext.Response.Cookies.Add(authCookie);
        }

        // GET: Manage/Account
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel account)
        {
            var accountdetails = db.Store_Login(account.UserName, account.Password).FirstOrDefault();

            if (accountdetails != null)
            {

                Authencicate(accountdetails);

                return RedirectToAction("Index", "ListModule", new { area = "Manage" });
            }

            else

            {
                ViewBag.Message = "Sai tên tài khoản hoặc mật khẩu. Vui lòng nhập lại";
                return View();
            }
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Login", "Account");
        }

        
    }
}
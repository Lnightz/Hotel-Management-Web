using HOTELMANAGEWEB.DAL;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.BLL
{
    public class AccountBLL
    {
        private static AccountBLL instance;

        public static AccountBLL Instance
        {
            get { if (instance == null) instance = new AccountBLL(); return instance; }
            private set => instance = value;
        }

        public Account GetAccountLogin(LoginModel model)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Store_Login(model.UserName, model.Password).FirstOrDefault();
            }

        } 
    }
}
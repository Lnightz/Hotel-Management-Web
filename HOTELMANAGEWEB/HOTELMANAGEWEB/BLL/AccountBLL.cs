using HOTELMANAGEWEB.DTO;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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

        private AccountBLL() { }

        public Account GetAccountLogin(LoginModel model)
        {
            using (var db = new QLKSWEBEntities())
            {
                var temp1 = db.AccountTypes.ToList();
                //var temp2 = db.AccountPermission.ToList();
                //var temp3 = db.Bill.ToList();
                //var temp4 = db.Booking.ToList();
                //var temp5 = db.Promotion.ToList();
                return db.Set<Account>()
                    .SqlQuery("EXEC Store_Login @UserName, @Password"
                    ,new SqlParameter("@UserName", model.UserName)
                    ,new SqlParameter("@Password",model.Password))
                    .FirstOrDefault();
            }

        } 

        
    }
}
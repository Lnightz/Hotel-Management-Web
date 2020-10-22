using HOTELMANAGEWEB.DTO;
using HOTELMANAGEWEB.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Data.Entity;

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
                    , new SqlParameter("@UserName", model.UserName)
                    , new SqlParameter("@Password", model.Password))
                    .FirstOrDefault();
            }

        }

        public List<Account> GetListAccount()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Accounts.Include(x => x.AccountType).ToList();
            }
        }

        public int LockUser(int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                Account account = db.Accounts.Find(id);
                account.Disabled = true;
                if (db.SaveChanges() > 1)
                {
                    return 1;
                }
                return -1;
            }
        }

        public int UnlockUser(int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                Account account = db.Accounts.Find(id);
                account.Disabled = false;
                if (db.SaveChanges() > 1)
                {
                    return 1;
                }
                return -1;
            }
        }

        public int AddPermission(AccountPermission permission)
        {
            using (var db = new QLKSWEBEntities())
            {
                AccountPermission check = db.AccountPermissions
                    .Where(x => x.AccountID == permission.AccountID && x.ModuleID == permission.ModuleID)
                    .FirstOrDefault();

                if (check != null)
                {
                    return -2;
                }

                AccountPermission account = new AccountPermission()
                {
                    AccountID = permission.AccountID,
                    ModuleID = permission.ModuleID
                };
                db.AccountPermissions.Add(account);
                if (db.SaveChanges() > 1)
                {
                    return 1;
                }
                return -1;
            }
        }

        public int RemovePermission(AccountPermission permission)
        {
            using (var db = new QLKSWEBEntities())
            {
                AccountPermission account = db.AccountPermissions
                    .Where(x => x.ModuleID == permission.ModuleID && x.AccountID == permission.ModuleID)
                    .FirstOrDefault();
                db.AccountPermissions.Remove(account);
                if (db.SaveChanges() > 1)
                {
                    return 1;
                }
                return -1;
            }
        }

        public Account ChangePassword(string username,ChangePassModel model)
        {
            Account user = null;
            using (var db = new QLKSWEBEntities())
            {
                user = db.Accounts.FirstOrDefault(x => x.UserName == username);

                if (user == null)
                {
                    return null;
                }

                if (user.Password != model.OldPassword)
                {
                    return null;
                }

                user.Password = model.NewPassword;

                if (db.SaveChanges() > 0)
                {
                    return user;
                }
            }
            return null;
        }

        public List<AccountPermission> GetUserPerMission(int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.AccountPermissions.Include(x => x.ModuleList)
                    .Where(x=>x.AccountID == id).ToList();
            }
        }

        public int Resetpass(int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                Account account = db.Accounts.Find(id);
                account.Password = "123";
                if (db.SaveChanges() > 0)
                {
                    return 1;
                }
                return -1;
            }
        }

        public int CreateAccount(Account account)
        {
            using (var db = new QLKSWEBEntities())
            {
                Account check = db.Accounts.Where(x => x.UserName == account.UserName).FirstOrDefault();
                if ( check != null)
                {
                    return -1;
                }
                Account accounts = new Account()
                {
                    UserName = account.UserName,
                    Password = account.Password,
                    AccountTypeID = account.AccountTypeID,
                    Disabled = false
                };
                db.Accounts.Add(accounts);
                if( db.SaveChanges() > 0)
                {
                    return 1;
                }
                return -1;
            }
        }

        public List<AccountType> GetListAccountTypes()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.AccountTypes.Where(x => x.Disabled == 0).ToList();
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;

namespace HOTELMANAGEWEB.BLL
{
    public class ManageBLL
    {
        private static ManageBLL instance;

        public static ManageBLL Instance
        {
            get { if (instance == null) instance = new ManageBLL(); return instance; }
            private set => instance = value;
        }

        public List<ModuleList> GetModules(string UserName)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                    .Database
                    .SqlQuery<ModuleList>
                    ("EXEC Get_Module @Username", new SqlParameter("@Username", UserName))
                    .ToList();
            }
        }

        public List<Service> GetServices()
        {
            using (var db = new QLKSWEBEntities())
            {
                var temp1 = db.ServicesTypes.ToList();
                return db.Services.Where(x => x.IsBookWithRoom == false)
                    .OrderBy(x => x.ServicesTypeID).ToList();
            }
        }

        public List<ServicesType> GetListServTypes()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.ServicesTypes
                    .Where(x => x.Disabled == 0)
                    .ToList();
            }
        }

        public Service GetServicesbyID (int? ID)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Services
                    .FirstOrDefault(x => x.ServicesID == ID);
            }
        }

        public int AddServs(Service model)
        {
            using (var db = new QLKSWEBEntities())
            {
                Service services = new Service
                {
                    ServicesName = model.ServicesName,
                    ServicesPrices = model.ServicesPrices,
                    ServicesTypeID = model.ServicesTypeID,
                    IsAvailable = model.IsAvailable,
                    IsBookWithRoom = model.IsBookWithRoom,
                    IsShow = model.IsShow,
                    IsShowHomePage = model.IsShowHomePage,
                    Unit = model.Unit,
                    ServicesContent = model.ServicesContent,
                    ServicesDescription = model.ServicesDescription,
                    ServicesDetail = model.ServicesDetail,
                    CreatedUserID = model.CreatedUserID,
                    DateCreated = model.DateCreated
                };
                db.Services.Add(services);
                if (db.SaveChanges() > 0)
                {
                    return 1;
                }
                else return -1;
            }
        }

        public int UpdateServ(Service model)
        {
            using (var db = new QLKSWEBEntities())
            {
                Service serv = ManageBLL.Instance.GetServicesbyID(model.ServicesID);
                serv.ServicesName = model.ServicesName;
                serv.ServicesPrices = model.ServicesPrices;
                serv.ServicesTypeID = model.ServicesTypeID;
                serv.IsAvailable = model.IsAvailable;
                serv.IsBookWithRoom = model.IsBookWithRoom;
                serv.IsShow = model.IsShow;
                serv.IsShowHomePage = model.IsShowHomePage;
                serv.Unit = model.Unit;
                serv.ServicesContent = model.ServicesContent;
                serv.ServicesDescription = model.ServicesDescription;
                serv.ServicesDetail = model.ServicesDetail;
                serv.ModifyUserID = model.ModifyUserID;
                serv.DateModify = model.DateModify;
                if (db.SaveChanges() > 0)
                {
                    return 1;
                }
                else return -1;
            }
        } 

        public List<ServicesType> GetListServType()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.ServicesTypes
                    .OrderBy(x => x.ServicesTypeName).ToList();
            }
        }

        public Account GetUserByUserName(string UserName)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Accounts.FirstOrDefault(x => x.UserName == UserName);
            }
        }

        public int DeleteServ(int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                var serv = db.Services.FirstOrDefault(x => x.ServicesID == id);
                db.Services.Remove(serv);
                if (db.SaveChanges() > 0)
                {
                    return 1;
                }
                else return -1;
            }
        }

        public List<ModuleList> GetModulesList()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.ModuleLists.ToList();
            }
        }

        public Equipment FinishMaintenance(int equiID)
        {
            using (var db = new QLKSWEBEntities())
            {
                var equip = db.Equipments.Find(equiID);
                equip.EquipStatus = 0;
                if (db.SaveChanges() > 0)
                {
                    return equip;
                }
                return null;
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;
using System.Data.Entity;
namespace HOTELMANAGEWEB.BLL
{
    public class RequestBLL
    {
        private static RequestBLL instance;

        public static RequestBLL Instance
        {
            get { if (instance == null) instance = new RequestBLL(); return instance; }
            private set => instance = value;
        }

        public List<Request> GetRequests()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Requests.Include(x => x.RequestType).ToList();
            }
        }

        public List<RequestType> GetRequestTypes()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.RequestTypes.ToList();
            }
        }

        public List<Equipment> GetEquipment()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Equipments.Where(x=>x.EquipStatus == 0).ToList();
            }
        }
    }
}
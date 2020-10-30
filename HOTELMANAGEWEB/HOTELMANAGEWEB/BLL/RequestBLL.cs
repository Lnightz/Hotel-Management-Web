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

        public Request DenyRequest(int RequestID)
        {
            using (var db = new QLKSWEBEntities())
            {
                var request = db.Requests.Find(RequestID);
                request.RequestStatus = "DENIED";
                if (db.SaveChanges() > 0)
                {
                    return request;
                }
                return null;
            }
        }

        public Request ApproveRequest(int RequestID)
        {
            using (var db = new QLKSWEBEntities())
            {
                var request = db.Requests.Find(RequestID);
                request.RequestStatus = "APPROVED";
                if (db.SaveChanges() > 0)
                {
                    return request;
                }
                return null;
            }
        }

        public bool CheckRoomIsUsed(int RequestID)
        {
            using (var db = new QLKSWEBEntities())
            {
                var request = db.Requests
                             .Include(x => x.Equipment)
                             .Where(x => x.RequestID == RequestID)
                             .FirstOrDefault();
                var room = db.Rooms.Find(request.Equipment.RoomID);
                if (room.RoomStatus == "OPEN")
                {
                    return false;
                }
                return true;
            }
        }
    }
}
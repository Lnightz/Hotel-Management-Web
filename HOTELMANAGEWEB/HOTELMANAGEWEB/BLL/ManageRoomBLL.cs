using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;

namespace HOTELMANAGEWEB.BLL
{
    public class ManageRoomBLL
    {
        private static ManageRoomBLL instance;

        public static ManageRoomBLL Instance
        {
            get { if (instance == null) instance = new ManageRoomBLL(); return instance; }
            private set => instance = value;
        }

        public string GetMaxFloor()
        {
            using (var db = new QLKSWEBEntities())
            {
                string maxFloor = db.Database.SqlQuery<string>("SELECT SUBSTRING(MAX(RoomName),1,1) AS MaxFloor FROM dbo.Room").FirstOrDefault();

                return maxFloor;
            }
        }

        public List<Room> GetRoomListByFloor(int floor)
        {
            using (var db = new QLKSWEBEntities())
            {
                var roomlist = db.Rooms.SqlQuery("SELECT * FROM dbo.Room WHERE SUBSTRING((RoomName),1,1) = @floor ", new SqlParameter("@floor",floor)).ToList();
                return roomlist;
            }
        }

        public List<RoomType> GetRoomTypesList()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.RoomTypes
                    .Where(x=>x.Disabled == 0)
                    .ToList();
            }
        }

        public RoomType GetRoomTypeByID (int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.RoomTypes
                    .Where(x => x.RoomTypeID == id)
                    .FirstOrDefault();
            }
        }

    }
}
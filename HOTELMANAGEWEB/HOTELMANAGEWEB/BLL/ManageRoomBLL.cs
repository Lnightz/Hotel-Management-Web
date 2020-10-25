using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;
using System.Data.Entity;

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
                string maxFloor;
                try
                {
                    maxFloor = db.Database.SqlQuery<string>("SELECT SUBSTRING(MAX(RoomName),1,1) AS MaxFloor FROM dbo.Room").FirstOrDefault();

                }
                catch (Exception)
                {

                    maxFloor = string.Empty;
                }

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

        public Room GetRoomByID (int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.Rooms
                    .Include(x => x.RoomType)
                    .FirstOrDefault(x => x.RoomID == id);
            }
        }


        public BookingRoom GetBookingbyRoomID(int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db.BookingRooms
                    .Include(x => x.Booking)
                    .Include(x => x.Room)
                    .Where(x => x.RoomID == id && x.IsBooking == 1)
                    .FirstOrDefault();
            }
        }

        public int GetRoomIDByBookingID(int bookingid)
        {
            using (var db = new QLKSWEBEntities())
            {
                var room = db.BookingRooms
                        .Include(x => x.Booking)
                        .Include(x => x.Room)
                        .Where(x => x.BookingID == bookingid).FirstOrDefault();
                if (room != null)
                {
                    return Convert.ToInt32(room.RoomID);
                }
                return -1;
            }
        }
    }
}
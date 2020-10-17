using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using HOTELMANAGEWEB.Models;
using HOTELMANAGEWEB.DTO;
using System.Data.Entity;

namespace HOTELMANAGEWEB.BLL
{
    public class BookingRoomBLL
    {
        private static BookingRoomBLL instance;

        public static BookingRoomBLL Instance
        {
            get { if (instance == null) instance = new BookingRoomBLL(); return instance; }
            private set => instance = value;
        }

        private BookingRoomBLL() { }
        public List<BookingRoom> GetListBooking()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                    .BookingRoom
                    .Include(x => x.Booking)
                    .Include(x => x.Booking.Customer)
                    .Include(x=> x.Room)
                    .Include(x => x.Room.RoomType)
                    .ToList();
            }
        }

        public BookingRoom GetBookingbyID (int? id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                    .BookingRoom
                    .Include(x => x.Booking)
                    .FirstOrDefault(x => x.BookingID == id);
            }
        }

    }
}
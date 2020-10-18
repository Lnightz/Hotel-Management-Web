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
        public List<Booking> GetListBooking()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                    .Booking
                    .Include(x => x.Customer)
                    .Include(x => x.RoomType)
                    .ToList();
            }
        }
        public Booking GetBookingbyID(int? id)
        {
            using (var db = new QLKSWEBEntities())
            {
                var bookinginfo = db
                                    .Booking
                                    .FirstOrDefault(x => x.BookingID == id);

                bookinginfo.BookingRooms = db.BookingRooms
                    .Where(x => x.BookingID == bookinginfo.BookingID)
                    .ToList();
                return bookinginfo;
            }
        }

        public int CheckCustomerInfo(string passport)
        {
            using (var db = new QLKSWEBEntities())
            {
                var result = db
                              .Customers
                              .FirstOrDefault(x => x.Passport == passport);
                if (result != null)
                {
                    return 1;
                }
                else return -1;
            }
        }
        public Customer GetCustomerByPassport(string passport)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                        .Customers
                        .FirstOrDefault(x => x.Passport == passport);
            }
        }

        public Service GetServicebyID(int id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                        .Services
                        .FirstOrDefault(x => x.ServicesID == id);
            }
        }

        public List<Room> GetRoomOpenWithTypeID(int? id)
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                    .Rooms
                    .Include(x => x.RoomType)
                    .Where(x => x.RoomStatus == "OPEN" && x.RoomTypeID == id)
                    .ToList();
            }
        }
    }
}
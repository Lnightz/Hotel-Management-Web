using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;
using HOTELMANAGEWEB.DAL;

namespace HOTELMANAGEWEB.BLL
{
    public class HomeBLL
    {
        private static HomeBLL instance;

        public static HomeBLL Instance
        {
            get { if (instance == null) instance = new HomeBLL(); return instance; }
            private set => instance = value;
        }

        public List<AvailableRoomModel> AvailableRooms(int? numperson, DateTime? checkin, DateTime? checkout)
        {
            using (var db = new QLKSWEBEntities())
            {
                List<AvailableRoomModel> availableRooms = db
                    .Database.
                    SqlQuery<AvailableRoomModel>("EXEC Find_AvailableRoom @NumPerson, @CheckinDate, @CheckoutDate",numperson,checkin,checkout)
                    .ToList();
                return availableRooms;
            }
        }


    }
}
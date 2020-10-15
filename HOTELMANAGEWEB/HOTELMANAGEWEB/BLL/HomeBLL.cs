using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;
using HOTELMANAGEWEB.DTO;
using System.Data.SqlClient;

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

        public List<AvailableRoomModel> AvailableRooms(CheckAvailableRooms model)
        {
            using (var db = new QLKSWEBEntities())
            {
                string checkinDate = model.CheckoutDate.HasValue? model.CheckinDate.Value.ToString("yyyy-MM-dd"): string.Empty;
                string checkoutDate = model.CheckoutDate.HasValue? model.CheckoutDate.Value.ToString("yyyy-MM-dd"): string.Empty;
                List<AvailableRoomModel> availableRooms = db
                    .Database
                    .SqlQuery<AvailableRoomModel>("EXEC Find_AvailableRoom @NumPerson, @CheckinDate, @CheckoutDate"
                    ,new SqlParameter("@NumPerson",model.NumberPerson)
                    ,new SqlParameter("@CheckinDate", checkinDate)
                    ,new SqlParameter("@CheckoutDate", checkoutDate))
                    .ToList();
                return availableRooms;
            }
        }

        public List<Service> BookServWithRoom()
        {
            using (var db = new QLKSWEBEntities())
            {
                return db
                    .Services
                    .Where(x => x.IsAvailable == 0 && x.IsBookWithRoom == 1)
                    .ToList();
            }
        }


    }
}
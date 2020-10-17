using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;

namespace HOTELMANAGEWEB.DTO
{
    public class BookRoomWithServModel
    {
        public int ServicesID { get; set; }

        public int IsSelected { get; set; }

    }

    public class ListServWithRoom
    {
        List<BookRoomWithServModel> listservwithroom { get; set; }
    }
}
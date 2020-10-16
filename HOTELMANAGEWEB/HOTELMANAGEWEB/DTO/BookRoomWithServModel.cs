using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using HOTELMANAGEWEB.Models;

namespace HOTELMANAGEWEB.DTO
{
    public class BookRoomWithServModel
    {
        public Services service { get; set; }

        public BookRoomWithServModel(BookRoomWithServModel book)
        {
            service = book.service;
        }

    }
}
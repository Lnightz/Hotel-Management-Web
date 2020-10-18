using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.BLL
{
    public class ServicesBLL
    {
        private static ServicesBLL instance;

        public static ServicesBLL Instance
        {
            get { if (instance == null) instance = new ServicesBLL(); return instance; }
            private set => instance = value;
        }


    }
}
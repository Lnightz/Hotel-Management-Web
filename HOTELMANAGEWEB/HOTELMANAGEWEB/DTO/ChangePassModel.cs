﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace HOTELMANAGEWEB.DTO
{
    public class ChangePassModel
    {
        [Required]
        public string OldPassword { get; set; }
        [Required]
        public string NewPassword { get; set; }
        [Required]
        public string ConFirmNewPassword { get; set; }

        public bool IsMatchNewPass
        {
            get
            {
                return string.Equals(NewPassword, ConFirmNewPassword);
            }
        }
    }
}
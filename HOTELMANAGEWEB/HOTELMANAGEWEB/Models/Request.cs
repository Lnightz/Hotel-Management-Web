//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace HOTELMANAGEWEB.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Request
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Request()
        {
            this.EquipRequest = new HashSet<EquipRequest>();
            this.RoomRequest = new HashSet<RoomRequest>();
        }
    
        public int RequestID { get; set; }
        public string RequesterName { get; set; }
        public Nullable<decimal> Prices { get; set; }
        public string RequestDescription { get; set; }
        public int RequestTypeID { get; set; }
        public int EquipmentID { get; set; }
        public int RoomID { get; set; }
        public string RequestStatus { get; set; }
        public Nullable<int> CreatedUserID { get; set; }
        public Nullable<int> ModifyUserID { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public Nullable<System.DateTime> DateModify { get; set; }
    
        public virtual Equipment Equipment { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EquipRequest> EquipRequest { get; set; }
        public virtual RequestType RequestType { get; set; }
        public virtual Room Room { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RoomRequest> RoomRequest { get; set; }
    }
}

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
    
    public partial class Equipment
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Equipment()
        {
            this.EquipRequest = new HashSet<EquipRequest>();
            this.MaintenanceHistory = new HashSet<MaintenanceHistory>();
            this.Request = new HashSet<Request>();
        }
    
        public int EquipmentID { get; set; }
        public string EquipmentName { get; set; }
        public Nullable<decimal> EquipPrices { get; set; }
        public Nullable<System.DateTime> DateBuy { get; set; }
        public byte EquipStatus { get; set; }
        public int EquipmentTypeID { get; set; }
        public int RoomID { get; set; }
        public Nullable<int> CreatedUserID { get; set; }
        public Nullable<int> ModifyUserID { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public Nullable<System.DateTime> DateModify { get; set; }
        public string Image { get; set; }
    
        public virtual EquipmentType EquipmentType { get; set; }
        public virtual Room Room { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<EquipRequest> EquipRequest { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MaintenanceHistory> MaintenanceHistory { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Request> Request { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace Inventory.Models
{
	public class Customer
	{
		[DisplayName("Customer Id")]
		public int Cid { get; set; }
		[DisplayName("Customer Name")]
		public string Cname { get; set; }
		public string Address { get; set; }
	}
}
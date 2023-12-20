using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace Inventory.Models
{
	public class Product
	{
		[DisplayName("Product Id")]
		public int Pid { get; set; }
		[DisplayName("Product Name")]
		public string Pname { get; set; }
		public decimal Price { get; set; }
	}
}
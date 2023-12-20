using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Inventory.Models
{
	public class Sale
	{
		public int CustomerId { get; set; }
		[DisplayName("Customer Name")]
		public string CustomerName { get; set; }
		[DisplayName("Product Name")]
		public string SelectProduct { get; set; }
		[DisplayName("Price")]
		public decimal ProductPrice { get; set; }
		[DisplayName("Date")]
		public DateTime SaleDate { get; set; }
	}
}
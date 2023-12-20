using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Inventory.Models
{
	public class SaleModel
	{
        public List<Product> Products { get; set; }
		public List<Sale> Sales { get; set; }
    }
}
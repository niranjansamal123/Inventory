using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Inventory.Models;

namespace Inventory.Controllers
{
    public class InventoryController : Controller
    {
        InventoryDAL dal=new InventoryDAL();

        #region Customer

        public ViewResult Customers()
		{
			return View();
		}

		[HttpGet]
		public ActionResult GetCustomerList()
		{
			var customers = dal.GetCustomerList();
			return Json(customers, JsonRequestBehavior.AllowGet);
		}
		
        [HttpGet]
        public ActionResult GetCustomerDetails(int Cid)
        {
            var customer = dal.GetCustomerDetails(Cid);
            return Json(customer, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult AddCustomer(Customer customer)
        {
            dal.InsertCustomer(customer);
            return Json("Customer added successfully");
        }

		[HttpPost]
		public ActionResult UpdateCustomer(Customer customer)
		{
			dal.UpdateCustomer(customer);
			return Json("Customer updated successfully");
		}

		[HttpPost]
		public ActionResult DeleteCustomer(int Cid)
		{
			dal.DeleteCustomer(Cid);
            return Json("Customer deleted successfully");
        }
        #endregion

        #region Product

		public ViewResult Products()
		{
			return View();
		}

        [HttpGet]
		public ActionResult GetProductList()
		{
			var products = dal.GetProductList();

            return Json(products, JsonRequestBehavior.AllowGet);
		}

		[HttpGet]
        public ActionResult GetProductDetails(int Pid)
        {
            var product = dal.GetProductDetails(Pid);

            return Json(product, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
		public ActionResult AddProduct(Product product)
		{
			dal.InsertProduct(product);

            return Json("Product added successfully");
		}

		[HttpPost]
        public ActionResult UpdateProduct(Product product)
        {
            dal.UpdateProduct(product);

            return Json("Product updated successfully");
        }

		[HttpPost]
		public ActionResult DeleteProduct(int Pid)
		{
			dal.DeleteProduct(Pid);

            return Json("Product deleted successfully");
        }

        #endregion

        #region Sale

		[HttpGet]
		public ViewResult Sales()
		{
            SaleModel objSaleModel = new SaleModel();
            objSaleModel.Sales = dal.GetSaleList();
            objSaleModel.Products = dal.GetProductList();
			return View(objSaleModel);
        }

        [HttpPost]
		public RedirectToRouteResult AddSale(Sale sale)
		{
			dal.InsertSale(sale);
			return RedirectToAction("Sales");
		}

		public string GetCustomerNameByCustomerID(int customerID)
		{
			var customerName = dal.GetCustomerNameByCustomerID(customerID);
			return customerName;
		}

		public string GetProductPriceByProductID(int Pid)
		{
			var productPrice = dal.GetProductPriceByProductID(Pid);
			return productPrice;
		}
        #endregion
    }
}
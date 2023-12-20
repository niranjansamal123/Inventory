using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Drawing;
using System.Security.Cryptography;

namespace Inventory.Models
{
	public class InventoryDAL
	{
		SqlCommand cmd;
		SqlConnection conn;
		public InventoryDAL()
		{
			string ConStr = ConfigurationManager.ConnectionStrings["ConStr"].ConnectionString;
			conn = new SqlConnection(ConStr);
			cmd = new SqlCommand();
			cmd.Connection = conn;
			cmd.CommandType = CommandType.StoredProcedure;
		}

		

        #region Customer

        public List<Customer> GetCustomerList()
        {
            List<Customer> list = new List<Customer>();
            try
            {
                cmd.Parameters.Clear();
                cmd.CommandText = "GetCustomerList";
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    Customer customer = new Customer
                    {
                        Cid = (int)dr["Cid"],
                        Cname = (string)dr["Cname"],
                        Address = (string)dr["Address"]
                    };
                    list.Add(customer);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
            return list;
        }

        public Customer GetCustomerDetails(int Cid)
        {
            Customer customer = null;
            try
            {
                cmd.Parameters.Clear();
                cmd.CommandText = "Customer_Select";
                cmd.Parameters.AddWithValue("@Cid", Cid);
                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    customer = new Customer
                    {
                        Cname = (string)dr["Cname"],
                        Address = (string)dr["Address"]
                    };
                }
            }
            catch
            {
                throw;
            }

            return customer;
        }

        public void InsertCustomer(Customer customer)
		{
			try
			{
				cmd.CommandText = "Customer_Insert";
				cmd.Parameters.Clear();
				cmd.Parameters.AddWithValue("@Cid", customer.Cid);
				cmd.Parameters.AddWithValue("@Cname", customer.Cname);
				cmd.Parameters.AddWithValue("@Address", customer.Address);
				conn.Open();
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				throw ex;
			}
			finally
			{
				conn.Close();
			}
		}

		public void UpdateCustomer(Customer customer)
		{
			try
			{
                cmd.CommandText = "Customer_Update";
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Cid", customer.Cid);
                cmd.Parameters.AddWithValue("@Cname", customer.Cname);
                cmd.Parameters.AddWithValue("@Address", customer.Address);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
			catch (Exception ex)
			{
				throw ex;
			}
			finally 
            { 
                conn.Close(); 
            }
		}

		public void DeleteCustomer(int Cid)
		{
			try
			{
                cmd.CommandText = "Customer_Delete";
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Cid", Cid);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
			catch (Exception ex)
			{
				throw ex;
			}
            finally
            {
                conn.Close();
            }
        }
        #endregion

        #region Product

        public List<Product> GetProductList()
        {
            List<Product> list = new List<Product>();
            try
            {
                cmd.Parameters.Clear();
                cmd.CommandText = "GetProductList";
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    Product product = new Product
                    {
                        Pid = (int)dr["Pid"],
                        Pname = (string)dr["Pname"],
                        Price = (decimal)dr["Price"]
                    };
                    list.Add(product);
                }
            }
            catch
            {
                throw;
            }
            return list;
        }

        public Product GetProductDetails(int Pid)
        {
            Product product = null;
            try
            {
                cmd.Parameters.Clear();
                cmd.CommandText = "Product_Select";
                cmd.Parameters.AddWithValue("@Pid", Pid);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    product = new Product
                    {
                        Pname = (string)dr["Pname"],
                        Price = (decimal)dr["Price"]
                    };
                }
                return product;

            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        public void InsertProduct(Product product)
		{
			try
			{
				cmd.CommandText = "Product_Insert";
				cmd.Parameters.Clear();
				cmd.Parameters.AddWithValue("@Pid", product.Pid);
				cmd.Parameters.AddWithValue("@Pname", product.Pname);
				cmd.Parameters.AddWithValue("@Price", product.Price);
				conn.Open();
				cmd.ExecuteNonQuery();
			}
			catch (Exception ex)
			{
				throw ex;
			}
			finally
			{
				conn.Close();
			}
		}
        public void UpdateProduct(Product product)
        {
            try
            {
                cmd.CommandText = "Product_Update";
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Pid", product.Pid);
                cmd.Parameters.AddWithValue("@Pname", product.Pname);
                cmd.Parameters.AddWithValue("@Price", product.Price);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        public void DeleteProduct(int Pid)
        {
            try
            {
                cmd.CommandText = "Product_Delete";
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Pid", Pid);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch(Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
        #endregion

        #region Sale

        public string GetCustomerNameByCustomerID(int customerID)
        {
            string customerName = null;

            try
            {
                cmd.CommandText = "GetCustomerNameByCustomerID";
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@customerID", customerID);

                conn.Open();

                customerName = Convert.ToString(cmd.ExecuteScalar());
            }
            catch
            {

                throw;
            }

            return customerName;
        }

        public string GetProductPriceByProductID(int Pid)
        {
            string productPrice = null;

            try
            {
                cmd.CommandText = "GetProductPriceByProductID";
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Pid", Pid);

                conn.Open();

                productPrice = Convert.ToString(cmd.ExecuteScalar());
            }
            catch
            {

                throw;
            }

            return productPrice;
        }
		
		public List<Sale> GetSaleList()
		{
			List<Sale> list = new List<Sale>();
			try
			{
				cmd.Parameters.Clear();
				cmd.CommandText = "GetSaleList";
				conn.Open();
				SqlDataReader dr = cmd.ExecuteReader();
				while (dr.Read())
				{
					Sale sale = new Sale
					{
						SelectProduct = (string)dr["SelectProduct"],
						CustomerName = (string)dr["CustomerName"],
						SaleDate = (DateTime)dr["SaleDate"],
						ProductPrice = (decimal)dr["ProductPrice"]
					};
					list.Add(sale);
				}
			}
			catch (Exception ex)
			{ 
				throw ex; 
			}
			finally
			{ 
				conn.Close(); 
			}
			return list;
		}

        public void InsertSale(Sale sale)
        {
            try
            {
                cmd.CommandText = "Sale_Insert";
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@CustomerId", sale.CustomerId);
                cmd.Parameters.AddWithValue("@CustomerName", sale.CustomerName);
                cmd.Parameters.AddWithValue("@SelectProduct", sale.SelectProduct);
                cmd.Parameters.AddWithValue("@ProductPrice", sale.ProductPrice);
                cmd.Parameters.AddWithValue("@SaleDate", sale.SaleDate);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }

        #endregion

    }
}
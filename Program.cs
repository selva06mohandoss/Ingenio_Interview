using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ingenio.CategoryApplication
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Ingenio_CategoryApplication");
            //Call the GetCategoryInfoByCategoryID SP  by passing CategoryID as a Parameter
            int categoryID = 201;
            GetCategoryInfoByCategoryID(categoryID);

            // Call the GetNameoftheCategoryByCategorylevel SP by passing CategoryID as PArameter
            int categorylevel = 2;
            GetNameoftheCategoryByCategorylevel(categorylevel);

            Console.ReadLine();
        }



        public static void GetCategoryInfoByCategoryID(int categoryID)
        {
            string connetionString = null;
            SqlConnection connection;
            SqlDataAdapter adapter;
            SqlCommand command = new SqlCommand();
            SqlParameter param;
            DataSet ds = new DataSet();


            connetionString = "Data Source=local;Initial Catalog=Ingenio_DB;User ID=sa;Password=compaq123";
            connection = new SqlConnection(connetionString);

            connection.Open();
            command.Connection = connection;
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetCategoryInfoByCategoryID";

            param = new SqlParameter("@CategoryID", categoryID);
            param.Direction = ParameterDirection.Input;
            param.DbType = DbType.Int32;
            command.Parameters.Add(param);

            adapter = new SqlDataAdapter(command);
            adapter.Fill(ds);

            for (int i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
            {
               
                Console.WriteLine(ds.Tables[0].Rows[i][0].ToString());
            }

            connection.Close();


        }
        
        public static void GetNameoftheCategoryByCategorylevel(int categorylevel)
        {
            string connetionString = null;
            SqlConnection connection;
            SqlDataAdapter adapter;
            SqlCommand command = new SqlCommand();
            SqlParameter param;
            DataSet ds = new DataSet();


            connetionString = "Data Source=local;Initial Catalog=Ingenio_DB;User ID=sa;Password=compaq123";
            connection = new SqlConnection(connetionString);

            connection.Open();
            command.Connection = connection;
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = "usp_GetNameoftheCategoryByCategorylevel";

            param = new SqlParameter("@level", categorylevel);
            param.Direction = ParameterDirection.Input;
            param.DbType = DbType.Int32;
            command.Parameters.Add(param);

            adapter = new SqlDataAdapter(command);
            adapter.Fill(ds);

            for (int i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
            {

                Console.WriteLine(ds.Tables[0].Rows[i][0].ToString());
            }

            connection.Close();


        }

    }
                                
}

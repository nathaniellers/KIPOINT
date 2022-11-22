using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using MySql.Data.Types;
using MySql.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace KIPOINT
{
    public partial class Blotter : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Close();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }


            if (!this.IsPostBack)
            {
                load_data();
                dropdown_name_for_complainant();
                dropdown_name_for_complainee();
            }
        }
        void load_data()
        {
            MySqlCommand cmd_load = new MySqlCommand("SELECT * FROM view_blotter", con);
            MySqlDataAdapter d = new MySqlDataAdapter(cmd_load);

            using (DataTable dt = new DataTable())
            {
                d.Fill(dt);
                blotter_list.DataSource = dt;
                blotter_list.DataBind();
            }
        }

        void cleartext()
        {

            txt_contact1.Text = "";
            txt_contact2.Text = "";
            txt_complaint.Text = "";
            txt_incidence.Text = "";
        }

        void dropdown_name_for_complainant()
        {
            using (MySqlCommand comr = new MySqlCommand("SELECT id ,CONCAT (fname, ' ', mi , '. ' , lname) AS 'Name' FROM residential_list GROUP BY NAME ASC ", con))
            {
                ddl_com1.Items.Clear();
                comr.CommandType = CommandType.Text;
                comr.Connection = con;


                using (MySqlDataReader sdr_req = comr.ExecuteReader())
                {

                    while (sdr_req.Read())
                    {

                        ListItem item_req = new ListItem();
                        item_req.Text = sdr_req["Name"].ToString();
                        item_req.Value = sdr_req["id"].ToString();
                        ddl_com1.Items.Add(item_req);
                    }
                }
                

            }
        }

        void dropdown_name_for_complainee()
        {
            using (MySqlCommand comr = new MySqlCommand("SELECT id ,CONCAT (fname, ' ', mi , '. ' , lname) AS 'Name' FROM residential_list GROUP BY NAME ASC ", con))
            {
                ddl_com2.Items.Clear();
                comr.CommandType = CommandType.Text;
                comr.Connection = con;


                using (MySqlDataReader sdr_req = comr.ExecuteReader())
                {

                    while (sdr_req.Read())
                    {

                        ListItem item_req = new ListItem();
                        item_req.Text = sdr_req["Name"].ToString();
                        item_req.Value = sdr_req["id"].ToString();
                        ddl_com2.Items.Add(item_req);
                    }
                }
            }
        }


        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            blotter_list.EditIndex = e.NewEditIndex;
            load_data();
        }
        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            blotter_list.EditIndex = -1;
            load_data();
        }
        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(blotter_list.DataKeys[e.RowIndex].Values[0]);

            MySqlCommand cmd = new MySqlCommand("delete FROM blotter where id=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            load_data();
        }

        void complainant(GridViewRowEventArgs e)
        {

            
            //MySqlCommand ocmd = new MySqlCommand("SELECT id ,CONCAT (fname, ' ', mi , ' ' , lname) AS 'Name' FROM residential_list GROUP BY NAME ASC ", con);
            //MySqlDataAdapter oda = new MySqlDataAdapter(ocmd);
            //MySqlCommandBuilder builder = new MySqlCommandBuilder(oda);
            //DataSet ds = new DataSet();
            //oda.Fill(ds);

            //DropDownList ddlreli = (DropDownList)e.Row.FindControl("ddl_complainant");
            
            //if (ddlreli != null)
            //{
            //    ddlreli.DataSource = null;
            //    ddlreli.DataSource = ds;                 
            //    ddlreli.DataValueField = "id";
            //    ddlreli.DataTextField = "Name";
            //    ddlreli.DataBind();
            //}
            //((DropDownList)e.Row.FindControl("ddl_complainant")).SelectedItem.Text = DataBinder.Eval(e.Row.DataItem, "complainant").ToString();


            using (MySqlCommand comr = new MySqlCommand("SELECT id ,CONCAT (fname, ' ', mi , ' ' , lname) AS 'Name' FROM residential_list GROUP BY NAME ASC ", con))
            {     
                comr.CommandType = CommandType.Text;
                comr.Connection = con;

                DropDownList ddlreli = (DropDownList)e.Row.FindControl("ddl_complainant");

                using (MySqlDataReader sdr_req = comr.ExecuteReader())
                {
                    ddlreli.DataSourceID = null;
                    while (sdr_req.Read())
                    {
                        ListItem item_req = new ListItem();
                        item_req.Text = sdr_req["Name"].ToString();
                        item_req.Value = sdr_req["id"].ToString();
                        ddlreli.Items.Add(item_req);
                    }
                }
                ((DropDownList)e.Row.FindControl("ddl_complainant")).SelectedValue = DataBinder.Eval(e.Row.DataItem, "complainant_id").ToString();

            }

        }

        void complainee(GridViewRowEventArgs e)
        {
            MySqlCommand ocmd = new MySqlCommand("SELECT id ,CONCAT (fname, ' ', mi , ' ' , lname) AS 'Name' FROM residential_list GROUP BY NAME ASC ", con);
            MySqlDataAdapter oda = new MySqlDataAdapter(ocmd);
            MySqlCommandBuilder builder = new MySqlCommandBuilder(oda);
            DataSet ds = new DataSet();
            oda.Fill(ds);

            DropDownList ddlreli = (DropDownList)e.Row.FindControl("ddl_complainee");

            if (ddlreli != null)
            {

                ddlreli.DataSource = ds;
                ddlreli.DataValueField = "id";
                ddlreli.DataTextField = "Name";
                ddlreli.DataBind();
            }
           ((DropDownList)e.Row.FindControl("ddl_complainee")).SelectedValue = DataBinder.Eval(e.Row.DataItem, "complainee_id").ToString();

        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = blotter_list.Rows[e.RowIndex];

            int id = Convert.ToInt32(blotter_list.DataKeys[e.RowIndex].Values[0]);

            DropDownList complainant = blotter_list.Rows[e.RowIndex].FindControl("ddl_complainant") as DropDownList;
            DropDownList complainee = blotter_list.Rows[e.RowIndex].FindControl("ddl_complainee") as DropDownList;
            DropDownList status = blotter_list.Rows[e.RowIndex].FindControl("ddl_status") as DropDownList;
            string contact1 = (row.FindControl("txt_contact1") as TextBox).Text;
            string contact2 = (row.FindControl("txt_contact2") as TextBox).Text;
            string complaint = (row.FindControl("txt_complaint") as TextBox).Text;
            string incidence = (row.FindControl("txt_incidence") as TextBox).Text;
            

            MySqlCommand cmd_edit = new MySqlCommand("UPDATE blotter SET complainant=@complainant, contact1=@contact1, complainee=@complainee, contact2=@contact2, complaint=@complaint, incidence=@incidence, status=@status  WHERE id = @id", con);

            
            cmd_edit.Parameters.AddWithValue("@complainant", complainant.SelectedValue);  
            cmd_edit.Parameters.AddWithValue("@contact1", contact1);
            cmd_edit.Parameters.AddWithValue("@complainee", complainee.SelectedValue);
            cmd_edit.Parameters.AddWithValue("@contact2", contact2);
            cmd_edit.Parameters.AddWithValue("@complaint", complaint);
            cmd_edit.Parameters.AddWithValue("@incidence", incidence);
            cmd_edit.Parameters.AddWithValue("@status", status.SelectedItem.Text);
            cmd_edit.Parameters.AddWithValue("@id", id);


            cmd_edit.ExecuteNonQuery();

            blotter_list.EditIndex = -1;
            load_data();

            cleartext();
            Label1.ForeColor = System.Drawing.Color.Green;
            Label1.Text = "Successfully updated!";
        }
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {

            if ((e.Row.RowType == DataControlRowType.DataRow) && ((e.Row.RowState & DataControlRowState.Edit) > 0))
            {
                //name
                complainant(e);
                complainee(e);

            }

            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != blotter_list.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            cleartext();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (txt_contact1.Text == "" | txt_contact2.Text == "" | txt_complaint.Text == "" | txt_incidence.Text == "" )
            {
                Label1.ForeColor = System.Drawing.Color.Red;
                Label1.Text = "Missing details. Kindly complete it!";
            }
            else
            {
                MySqlCommand cmd_add = new MySqlCommand("INSERT INTO blotter (date,complainant,contact1,complainee,contact2,complaint,incidence,status,assist_by) VALUES (@date,@complainant,@contact1,@complainee,@contact2,@complaint,@incidence,@status,@assist_by)", con);

          

                cmd_add.Parameters.AddWithValue("@date", DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss "));
                cmd_add.Parameters.AddWithValue("@complainant", ddl_com1.SelectedValue);
                cmd_add.Parameters.AddWithValue("@contact1", txt_contact1.Text);
                cmd_add.Parameters.AddWithValue("@complainee", ddl_com2.SelectedValue);
                cmd_add.Parameters.AddWithValue("@contact2", txt_contact2.Text);
                cmd_add.Parameters.AddWithValue("@complaint", txt_complaint.Text);
                cmd_add.Parameters.AddWithValue("@incidence", txt_incidence.Text);
                cmd_add.Parameters.AddWithValue("@status", ddl_status.SelectedItem.Text);
                cmd_add.Parameters.AddWithValue("@assist_by", Session["id"]);
                cmd_add.ExecuteNonQuery();

                load_data();

                cleartext();
                Label1.ForeColor = System.Drawing.Color.Green;
                Label1.Text = "Successfully added!";
                Response.Redirect(Request.Url.AbsoluteUri);
            }
        }
    }
}
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
using System.Globalization;
using System.Diagnostics;
using System.Text;

namespace KIPOINT
{
    public partial class RegisterResidential : System.Web.UI.Page
    {
        MySqlConnection con = new MySqlConnection(ConfigurationManager.ConnectionStrings["MyDB"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Close();
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            if (this.IsPostBack)
            {
                DropdownReligion();
            }
        }

        void cleartext()
        {
            txt_fname.Text = "";
            txt_lname.Text = "";
            txt_mname.Text = "";
        }

        void DropdownReligion()
        {
           using (MySqlCommand com_id = new MySqlCommand("select id , religion_name from religion", con))
            {
                com_id.CommandType = CommandType.Text;
                com_id.Connection = con;
                using (MySqlDataReader sdr_id = com_id.ExecuteReader())
                {
                    while (sdr_id.Read())
                    {
                        ListItem item_id = new ListItem();
                        item_id.Text = sdr_id["religion_name"].ToString();
                        item_id.Value = sdr_id["id"].ToString();
                        DrpReligion.Items.Add(item_id);
                    }
                }
            }
        }

        Boolean ValidateUserInfo(string lname, string fname, string mi)
        {
            string qry = "SELECT * FROM user WHERE firstname=@firstname and lastname=@lastname and mi=@mi";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@lastname", lname);
            cmd.Parameters.AddWithValue("@firstname", fname);
            cmd.Parameters.AddWithValue("@mi", mi);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                string firstname = dt.Rows[0]["firstname"].ToString();
                string lastname = dt.Rows[0]["lastname"].ToString();
                string middle = dt.Rows[0]["mi"].ToString();
                
                if (lastname == lname && firstname == fname && middle == mi)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
      
        }

        void FetchResidentialsInfo(string lname, string fname, string mi)
        {
            string qry = "SELECT * FROM view_residential WHERE fname=@fname and lname=@lname and mi=@mi";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@lname", lname);
            cmd.Parameters.AddWithValue("@fname", fname);
            cmd.Parameters.AddWithValue("@mi", mi);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count >= 1)
            {
                Session["Register_id"] = int.Parse(dt.Rows[0]["id"].ToString());
                string firstname = dt.Rows[0]["fname"].ToString();
                string lastname = dt.Rows[0]["lname"].ToString();
                string middle = dt.Rows[0]["mi"].ToString();
                string gender = dt.Rows[0]["gender"].ToString();
                string marital_status = dt.Rows[0]["marital_status"].ToString();
                string house_no = dt.Rows[0]["household_no"].ToString();
                string street = dt.Rows[0]["street"].ToString();
                string zone = dt.Rows[0]["zone"].ToString();
                string bday = dt.Rows[0]["bday"].ToString();
                string bplace = dt.Rows[0]["bplace"].ToString();
                string religion = dt.Rows[0]["religion"].ToString(); //selectedValue in dropdown
                string occupation = dt.Rows[0]["occupation"].ToString();

                if (lastname == lname && firstname == fname && middle == mi)
                {
                    lbl_msg.ForeColor = System.Drawing.Color.Green;
                    lbl_msg.Text = "Kindly check and complete the Residential information.";
                    PanelResidentailInfo.Visible = true;
                    DrpGender.SelectedValue = gender;
                    DrpMaritalStatus.SelectedValue = marital_status;
                    txt_dob.Text = dt.Rows[0]["bday"].ToString();
                    txt_houseNo.Text = house_no;
                    txt_street.Text = street;
                    DrpZone.SelectedValue = zone;
                    DrpReligion.SelectedValue = dt.Rows[0]["religion_id"].ToString();
                    txt_occupation.Text = occupation;
                    txt_bplace.Text = bplace;
                    btn_ok.Text = "Submit";

                }
                else
                {
                    lbl_msg.ForeColor = System.Drawing.Color.Red;
                    lbl_msg.Text = "The date you input are invalid. Kindly check with Staff to assist you.";
                }

            }
            else
            {
                lbl_msg.ForeColor = System.Drawing.Color.Red;
                lbl_msg.Text = "The date you input are invalid. Kindly check with Staff to assist you.";
            }
        }

        public Boolean CheckDataSubmit(string uname, int id)
        {
            //to check if there's any same entry in db
            string qry = "SELECT  * from user where username=@username and id!=@id";
            MySqlCommand cmd = new MySqlCommand(qry, con);
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@username", uname);
            cmd.Parameters.AddWithValue("@id", id);

            MySqlDataAdapter d = new MySqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            d.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                return true;
            }
            return false;
        }

        void UpdateResidentialInfor()
        {
            MySqlCommand cmd = new MySqlCommand("UPDATE residential_list SET fname = @fname, lname = @lname, mi = @mi, gender = @gender, marital_status = @marital_status , household_no=@household_no , street=@street , zone=@zone, bday=@bday , bplace=@bplace , religion=@religion, occupation=@occupation WHERE id = @id", con);

            cmd.Parameters.AddWithValue("@id", Session["Register_id"]);
            cmd.Parameters.AddWithValue("@fname", txt_fname.Text);
            cmd.Parameters.AddWithValue("@lname", txt_lname.Text);
            cmd.Parameters.AddWithValue("@mi", txt_mname.Text);
            cmd.Parameters.AddWithValue("@gender", DrpGender.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@marital_status", DrpMaritalStatus.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@household_no", txt_houseNo.Text);
            cmd.Parameters.AddWithValue("@street", txt_street.Text);
            cmd.Parameters.AddWithValue("@zone", DrpZone.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@bday", txt_dob.Text);
            cmd.Parameters.AddWithValue("@bplace", txt_bplace.Text);
            cmd.Parameters.AddWithValue("@religion", DrpReligion.SelectedValue); ;
            cmd.Parameters.AddWithValue("@occupation", txt_occupation.Text);
            cmd.ExecuteNonQuery();
            lbl_msg.ForeColor = System.Drawing.Color.Green;
            lbl_msg.Text = "Successfully Submited";
        }

        protected void btn_ok_Click(object sender, EventArgs e)
        {
            if (btn_ok.Text == "Search") 
            {
                if (ValidateUserInfo(txt_lname.Text, txt_fname.Text, txt_mname.Text) == true)
                {
                    lbl_msg.ForeColor = System.Drawing.Color.Red;
                    lbl_msg.Text = "Residential input is already have user account.";
                }
                else
                {
                    FetchResidentialsInfo(txt_lname.Text, txt_fname.Text, txt_mname.Text);
                    txt_fname.Enabled = false;
                    txt_lname.Enabled = false;
                    txt_mname.Enabled = false;
                }
            } 
            else if (btn_ok.Text == "Submit") 
            {
                if (txt_dob.Text == "" || txt_houseNo.Text == "" || txt_street.Text == "" || txt_occupation.Text == "" || txt_bplace.Text == "") {
                    lbl_msg.ForeColor = System.Drawing.Color.Red;
                    lbl_msg.Text = "Kindly complete the details in Residential information before submitting it.";
                } 
                else 
                {
                    UpdateResidentialInfor();
                    PanelSecretQuestion.Visible = true;
                    DrpGender.Enabled = false;
                    DrpMaritalStatus.Enabled = false;
                    DrpReligion.Enabled = false;
                    DrpZone.Enabled = false;
                    txt_dob.Enabled = false;
                    txt_bplace.Enabled = false;
                    txt_houseNo.Enabled = false;
                    txt_occupation.Enabled = false;
                    txt_street.Enabled = false;                   
                    btn_ok.Text = "Create Account";
                }
            }
            else if (btn_ok.Text == "Create Account")
            {
                if (txt_username.Text =="" || txt_SecretPass.Text == "" )
                {
                    lbl_msg.ForeColor = System.Drawing.Color.Red;
                    lbl_msg.Text = "Missing details. Kindly complete before submitting it.";
                }
                else
                {
                    if (CheckDataSubmit(txt_username.Text, 0) == true)
                    {
                        lbl_msg.ForeColor = System.Drawing.Color.Red;
                        lbl_msg.Text = "Username that you input is already exist in the system.";
                    }
                    else
                    {
                        MySqlCommand cmd = new MySqlCommand("Insert INTO user (firstname,lastname,mi,username,user_type,secret_question,secret_answer,password,resi_id) VALUES (@firstname,@lastname,@mi,@username,@user_type,@secret_question,@secret_answer,@password,@resi_id) ", con);

                        cmd.Parameters.AddWithValue("@firstname", txt_fname.Text);
                        cmd.Parameters.AddWithValue("@lastname", txt_lname.Text);
                        cmd.Parameters.AddWithValue("@mi", txt_mname.Text);
                        cmd.Parameters.AddWithValue("@username", txt_username.Text);
                        cmd.Parameters.AddWithValue("@user_type", "Residential");
                        cmd.Parameters.AddWithValue("@secret_question", txt_SecretQuestion.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@secret_answer", txt_SecretPass.Text);
                        cmd.Parameters.AddWithValue("@password", txt_username.Text + "@" + txt_dob.Text.Replace("-","")) ;
                        cmd.Parameters.AddWithValue("@resi_id", Session["Register_id"]);
                        
                        cmd.ExecuteNonQuery();
                        PanelPassword.Visible = true;
                        txt_username.Enabled = false;
                        txt_SecretQuestion.Enabled = false;
                        txt_SecretPass.Enabled = false;
                        txt_SecretPass.Text = "";
                        btn_ok.Text = "Create your Password";
                        lbl_msg.ForeColor = System.Drawing.Color.Red;
                        lbl_msg.Text = "Account has been created. Note: If you close this page without Password, you can still login by using the default password with this format(username@birthday(yyyymmdd))";
                    }
                }
            } 
            else 
            {
                if (txt_pass.Text.Length >= 5 & txt_confirmpass.Text.Length >= 5)
                {
                    MySqlCommand cmd = new MySqlCommand("UPDATE user SET password= @password , is_active=@is_active WHERE username = @username", con);
                    cmd.Parameters.AddWithValue("@username", txt_username.Text);           
                    cmd.Parameters.AddWithValue("@is_active", 1);
                    cmd.Parameters.AddWithValue("@password", txt_confirmpass.Text);
                    cmd.ExecuteNonQuery();
                    txt_confirmpass.Enabled = false;
                    txt_pass.Enabled = false;
                    txt_confirmpass.Text = "";
                    txt_pass.Text = "";
                    btn_ok.Visible = false;
                    lbl_msg.ForeColor = System.Drawing.Color.LimeGreen;
                    lbl_msg.Text = "Your account has been retrieve succesfully. Kindly re-login your account. ";
                }
                else
                {
                    lbl_msg.ForeColor = System.Drawing.Color.Red;
                    lbl_msg.Text = "You need to write at least 5 characters on your password";
                }

            }
        }

        protected void btn_no_Click(object sender, EventArgs e)
        {
           
                cleartext();
                Response.Redirect("/LoginPage.aspx");
            
        }

    
    }
}
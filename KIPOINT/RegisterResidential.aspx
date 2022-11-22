<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RegisterResidential.aspx.cs" Inherits="KIPOINT.RegisterResidential" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .modal-body{
            display: flex;
            flex-direction: column;
        }
        
        span{
            text-align:left;
        }
        .auto-style2 {
            width: 469px;
        }
        .auto-style3 {
            width: 67%;
        }
        .auto-style4 {
            width: 470px;
        }
    </style>

    <br />

    <div class="card pb-3">
     <div class="container-fluid">
         
         <div class="modal-content">   
             <div class="modal-header">
                 <h3>Residential Registration</h3>
             </div>
             <div class="modal-body">


                 <table class="auto-style3" align="center">
                     <tr>
                         <td class="auto-style4">Lastname*</td>
                         <td><asp:TextBox ID="txt_lname" runat="server" Height="25px" Width="200px"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="auto-style4">Firstname*</td>
                         <td><asp:TextBox ID="txt_fname" runat="server" Height="25px" Width="200px"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="auto-style4">Middlename*</td>
                         <td><asp:TextBox ID="txt_mname" runat="server" Height="25px" Width="200px"></asp:TextBox></td>
                     </tr>
                 </table>


                 <br />
                 <asp:Panel ID="PanelResidentailInfo" runat="server" Visible="False">
                  <table class="auto-style3" align="center">
                     <tr>
                         <td class="auto-style2">Gender*</td>
                         <td><asp:DropDownList ID="DrpGender" runat="server" Height="25px" Width="200px"> 
                                <asp:ListItem Value="--SELECT--"></asp:ListItem>
                                <asp:ListItem Value="Male"></asp:ListItem>
                                <asp:ListItem Value="Female"></asp:ListItem>
                            </asp:DropDownList>
                         </td>
                     </tr>
                     <tr>
                         <td class="auto-style2">Marital Status*</td>
                         <td><asp:DropDownList ID="DrpMaritalStatus" runat="server" Height="25px" Width="200px">
                          <asp:ListItem Value="--SELECT--"></asp:ListItem>
                            <asp:ListItem Value="Single"></asp:ListItem>
                            <asp:ListItem Value="Married"></asp:ListItem>
                            <asp:ListItem Value="Widowed"></asp:ListItem>
                            <asp:ListItem Value="Separated"></asp:ListItem>
                            <asp:ListItem Value="Divorced"></asp:ListItem>
                        </asp:DropDownList>
                        </td>
                     </tr>
                     <tr>
                         <td class="auto-style2">Date of Birth*</td>
                         <td><asp:TextBox ID="txt_dob" runat="server" Height="25px" Width="200px" TextMode="Date"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="auto-style2">Household no*</td>
                         <td><asp:TextBox ID="txt_houseNo" runat="server" Height="25px" Width="200px" TextMode="number"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="auto-style2">Street*</td>
                         <td><asp:TextBox ID="txt_street" runat="server" Height="25px" Width="200px" TextMode="SingleLine"></asp:TextBox></td>
                     </tr>
                      <tr>
                         <td class="auto-style2">Zone*</td>
                         <td><asp:DropDownList ID="DrpZone" runat="server" Height="25px" Width="200px">
                                <asp:ListItem Value="--SELECT--"></asp:ListItem>
                                <asp:ListItem Value="3"></asp:ListItem>
                                <asp:ListItem Value="4"></asp:ListItem>
                            </asp:DropDownList>
                         </td>
                     </tr>
                     <tr>
                         <td class="auto-style2">Religion*</td>
                         <td><asp:DropDownList ID="DrpReligion" runat="server" Height="25px" Width="200px"></asp:DropDownList></td>
                     </tr>
                     <tr>
                         <td class="auto-style2">Occupation*</td>
                         <td><asp:TextBox ID="txt_occupation" runat="server" Height="25px" Width="200px" TextMode="SingleLine"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="auto-style2">Birthplace*</td>
                         <td><asp:TextBox ID="txt_bplace" runat="server" Height="25px" Width="200px" TextMode="SingleLine"></asp:TextBox></td>
                     </tr>
                 </table>
</asp:Panel>
                 <br />

                 <asp:Panel ID="PanelSecretQuestion" runat="server" Visible="False">
                 <table class="auto-style3" align="center">
                     <tr>
                         <td class="auto-style4">Username*</td>
                         <td><asp:TextBox ID="txt_username" runat="server" Height="25px" Width="200px"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="auto-style4">Secret Question*</td>
                         <td>
                         <asp:DropDownList ID="txt_SecretQuestion" runat="server" Height="25px" Width="200px">
                            <asp:ListItem>In what city were you born?</asp:ListItem>
                            <asp:ListItem Value="What is the name of your favorite pet?"></asp:ListItem>
                            <asp:ListItem Value="What high school did you attend?"></asp:ListItem>
                            <asp:ListItem Value="What is the name of your first school?"></asp:ListItem>
                            <asp:ListItem Value="What was the make of your first car?"></asp:ListItem>
                            <asp:ListItem Value="What was your favorite food as a child?"></asp:ListItem>
                            <asp:ListItem Value="Where did you meet your spouse?"></asp:ListItem>
                        </asp:DropDownList>
                         </td>
                     </tr>
                     <tr>
                         <td class="auto-style4">Secrect Password*</td>
                         <td><asp:TextBox ID="txt_SecretPass" runat="server" Height="25px" Width="200px" TextMode="Password"  ></asp:TextBox></td>
                     </tr>
                 </table>
                 </asp:Panel>

                 <br />

                 <asp:Panel ID="PanelPassword" runat="server" Visible="False">
                 <table class="auto-style3" align="center">
                     <tr>
                         <td class="auto-style4">Password*</td>
                         <td><asp:TextBox ID="txt_pass" runat="server" Height="25px" Width="200px" TextMode="Password"></asp:TextBox></td>
                     </tr>
                     <tr>
                         <td class="auto-style4">Confirmation Password*</td>
                         <td><asp:TextBox ID="txt_confirmpass" runat="server" Height="25px" Width="200px" TextMode="Password"></asp:TextBox></td>
                     </tr>

                 </table>
                </asp:Panel>

             </div>
              <span>&nbsp;<asp:Label ID="lbl_msg" runat="server"></asp:Label></span>
             <br />

             <div class="modal-footer">
                 
                  <asp:Button ID="btn_no" runat="server" Text="Close" class="btn btn-danger" OnClick="btn_no_Click" />
                  <asp:Button ID="btn_ok" runat="server" Text="Search" class="btn btn-success" OnClick="btn_ok_Click" />                    
             </div>
         </div>

     </div>
    </div>

</asp:Content>

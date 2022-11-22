<%@ Page Title="REQUEST" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReservationViewREQ.aspx.cs" Inherits="KIPOINT.ReservationViewREQ" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

      <style>
          table {
            border-collapse: collapse;
            border-spacing: 0;
        }

        td,
        th {
            padding: 2px;
           
        }
        .modal-header {
            padding: 10px;
        }
        .modal-footer {
            padding: 10px;
        }

        .modal-body {
            padding: 0;
        }
        .modal-content {
            margin-top: 20px;
        }
          .auto-style1 {
              height: 22px;
          }
          .auto-style2 {
              width: 252px;
              height: 22px;
          }
          .auto-style4 {
              height: 35px;
          }
          .auto-style6 {
              position: relative;
              left: 0px;
              top: 0px;
              padding: 0;
          }
          .auto-style7 {
              position: relative;
              left: 283px;
              top: -5px;
              width: 685px;
              padding: 0;
          }
          .auto-style8 {
              height: 35px;
              width: 252px;
          }
       </style>

     <div class="card pb-3">
     <div class="container-fluid">
               <div class="modal-content">  
                   <div class="modal-header" style="background:#666666; padding: 0px;">
                       <h1 class="status">&nbsp;<asp:Label ID="lbl_status" runat="server" Text="Status" Height="50px" Width="500px" Font-Italic="True"></asp:Label></h1>
                   </div>
                   
                   <div class="auto-style7">'
                        <table align="center" class="nav-justified">
                            <tr>
                            <td class="auto-style2">Request</td>
                            <td class="auto-style1" >
                                <asp:TextBox ID="txt_req" runat="server" Height="25px" Width="200px" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Equipment Name*</td>
                            <td class="auto-style1">
                                <asp:TextBox ID="txt_equipment" runat="server" Height="25px" Width="200px" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Equipment No</td>
                            <td class="auto-style1">
                                <asp:TextBox ID="txt_eq_num" runat="server" Height="25px" Width="200px" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Equipment Brand</td>
                            <td class="auto-style1">
                                <asp:TextBox ID="txt_brand" runat="server" Height="25px" Width="200px" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Purpose*</td>
                            <td class="auto-style1">
                                <asp:TextBox ID="txt_purpose" runat="server" Height="79px" Width="200px" Enabled="False" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style8">Date start*</td>
                            <td class="auto-style4">
                                <asp:TextBox ID="txt_datestart" runat="server" Height="25px" Width="200px" TextMode="Date" Enabled="False" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Date end*</td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txt_dateend" runat="server" Height="25px" Width="200px" TextMode="Date" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Time start*</td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txt_timestart" runat="server" Height="25px" Width="200px" TextMode="Time" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Time end*</td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txt_timeend" runat="server" Height="25px" Width="200px" TextMode="Time" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Reserved by*</td>
                            <td style="height: 22px">
                                <asp:TextBox ID="txt_reservedby" runat="server" Height="25px" Width="200px" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style2">Remarks</td>
                            <td style="height: 22px">
                                <asp:TextBox ID="txt_remarks" runat="server" Height="74px" Width="200px" Enabled="False" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                            <td class="auto-style6" colspan="2">
                                &nbsp;</td>
                            </tr>
                            </table>
                   </div>
                    &nbsp;<asp:Label ID="Label1" runat="server"></asp:Label>
                   <div class="modal-footer">
                       
                       <asp:Button ID="btn_approve" runat="server" Text="Approved" class="btn btn-success" OnClick="btn_approve_Click" />                    
                       <asp:Button ID="btn_disapprove" runat="server" Text="Disapproved" class="btn btn-danger" OnClick="btn_disapprove_Click" />
                       <asp:Button ID="btn_reschedule" runat="server" Text="Reschedule" class="btn btn-info" OnClick="btn_reschedule_Click" />  
                   </div>

              </div>
      </div>
      </div>


</asp:Content>

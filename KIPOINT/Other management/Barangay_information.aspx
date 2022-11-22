<%@ Page Title="Barangay Information" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Barangay_information.aspx.cs" Inherits="KIPOINT.Barangay_information" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       
    <style>
         table {
          border-collapse: collapse;
          border-spacing: 0;
        }

        td,
        th {
            padding: 3px;
        }
            .auto-style1 {
            width: 450px;
            height: 22px;
        }
            
        .auto-style3 {
            height: 22px;
            width: 612px;
        }
    
        .auto-style4 {
            height: 22px;
        }
        .container-fluid {
            margin-top: 50px;
        }
    
    </style>

     <div class="container-fluid">

    <div class="row mb-3 text-center">
        <div class ="col-md-8 themed-grid-col">
          
                <table style="width: 100%; height: 130px">
                    <tr>
                        <td class="auto-style3">&nbsp;</td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">&nbsp;</td>
                        <td style="height: 22px; width: 450px">Barangay Name</td>
                        <td style="height: 22px; width: 450px">
                            <asp:TextBox ID="txt_bname" runat="server" Height="25px" Width="300px"></asp:TextBox>
                        </td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">&nbsp;</td>
                        <td style="height: 22px; width: 450px">City</td>
                        <td style="height: 22px; width: 450px">
                            <asp:TextBox ID="txt_city" runat="server" Height="25px" Width="300px"></asp:TextBox>
                        </td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">&nbsp;</td>
                        <td style="height: 22px; width: 450px">District</td>
                        <td style="height: 22px; width: 450px">
                            <asp:TextBox ID="txt_district" runat="server" Height="25px" Width="300px"></asp:TextBox>
                        </td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3"></td>
                        <td class="auto-style1"></td>
                        <td class="auto-style1">
                            
                        </td>
                        <td class="auto-style1"></td>
                    </tr>
                    <tr>
                        <td class="auto-style3">&nbsp;</td>
                        <td class="auto-style4" colspan="2">
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                        </td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style3">
                            &nbsp;</td>
                        <td style="height: 22px; width: 450px">&nbsp;</td>
                        <td style="height: 22px; width: 450px">
                            <asp:Button ID="btn_update" runat="server" Height="30px" OnClick="btn_update_Click" Text="Update" Width="246px"  class="btn btn-success"/>
                        </td>
                        <td style="height: 22px; width: 450px">
                            &nbsp;</td>
                    </tr>
                </table>
           
        </div>
        <div class="col-md-4 themed-grid-col">
           <asp:Image ID="logo" runat="server" Height="150px" Width="150px" />
           <asp:FileUpload ID="Fileupload" runat="server" Height="25px" Width="300px" />
           
        </div>
    </div>
</div>

</asp:Content>

 
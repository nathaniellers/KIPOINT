<%@ Page Title="Term" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Term.aspx.cs" Inherits="KIPOINT.Other_management.Term" %>
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
            height: 22px;
            width: 0;
        }
        .container-fluid{
            margin-top: 50px;
        }
            
    </style>

    <div class="container-fluid">

        <table align="center" class="nav-justified" style="padding: 2px">
            <tr>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td style="height: 22px"; width="400px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td style="height: 22px"; width="400px">Term Start</td>
                <td style="height: 22px"; width="400px">
                    <asp:TextBox ID="txt_TermStart" runat="server" Height="25px" TextMode="Date" Width="200px"></asp:TextBox>
                </td>
                <td style="height: 22px"; width="400px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td style="height: 22px"; width="400px">Term End</td>
                <td style="height: 22px"; width="400px">
                    <asp:TextBox ID="txt_TermEnd" runat="server" Height="25px" TextMode="Date" Width="200px"></asp:TextBox>
                </td>
                <td style="height: 22px"; width="400px" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td style="height: 22px"; width="400px">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </td>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td ; width="400px" class="auto-style1">
                    <asp:Button ID="btn_add" runat="server" Height="30px" OnClick="btn_add_Click" Text="Update" Width="150px" class="btn btn-success"/>
                </td>
                <td style="height: 22px; width: 200px;"; width="400px">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="height: 22px"; width="400px">
                    &nbsp;</td>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td style="height: 22px"; width="400px">&nbsp;</td>
                <td ; width="400px" class="auto-style1">
                    &nbsp;</td>
                <td style="height: 22px; width: 200px;"; width="400px">
                    &nbsp;</td>
            </tr>
         </table>


        

        <br />

   </div>
    
</asp:Content>

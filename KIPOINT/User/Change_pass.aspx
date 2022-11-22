<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Change_pass.aspx.cs" Inherits="KIPOINT.Change_pass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .nav-justified{
            margin-top: 50px;
        }
    </style>
    <br />

    <table class="nav-justified">
        <tr>
            <td style="width: 459px; height: 31px"></td>
            <td class="modal-sm" style="width: 250px; height: 31px">Current Password*</td>
            <td style="height: 31px; width: 209px;">
                <asp:TextBox ID="CurrentPass" runat="server" MaxLength="10" TextMode="Password" Width="138px"></asp:TextBox>
            </td>
            <td style="height: 31px; width: 459px"></td>
        </tr>
        <tr>
            <td style="width: 459px; height: 31px"></td>
            <td style="width: 250px; height: 31px">New Password*</td>
            <td style="height: 31px; width: 209px;">
                <asp:TextBox ID="NewPass" runat="server" MaxLength="10" TextMode="Password" Width="139px"></asp:TextBox>
            </td>
            <td style="height: 31px"></td>
        </tr>
        <tr>
           <td style="width: 459px; height: 31px"></td>
            <td style="width: 250px; height: 31px">Confirm New Password*</td>
            <td style="height: 31px; width: 209px;">
                <asp:TextBox ID="ConfirmPass" runat="server" MaxLength="10" TextMode="Password" Width="142px"></asp:TextBox>
            </td>
            <td style="height: 31px"></td>
        </tr>
        <tr>
            <td style="width: 459px; height: 31px"></td>
            <td colspan="2" style="height: 14px">
                <asp:Label ID="Label1" runat="server" ></asp:Label>
            </td>
            <td style="height: 14px"></td>
        </tr>
        <tr>
           <td style="width: 459px; height: 31px"></td>
            <td class="modal-sm" style="width: 250px">
                <asp:Button ID="Button1" runat="server" Text="Change Password" OnClick="Button1_Click" Width="160px" class="btn btn-success" />
            </td>
            <td style="width: 209px">
                <asp:Button ID="Button2" runat="server" Text="Cancel" Width="147px" OnClick="Button2_Click" class="btn btn-danger" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>


</asp:Content>

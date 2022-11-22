<%@ Page Title="Update Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="KIPOINT.User.Account" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>

        .card-card-header{
            margin-top: 50px;
        }

    </style>
 <br />



            <div class="card-card-header">
             <table style="width: 100%; height: 100px">
                    <tr>
                        <td style="height: 23px; width: 347px;"></td>
                        <td style="width: 66px; height: 25px;">
                            Firstname*</td>
                        <td style="height: 24px; width: 14px;">
                            <asp:TextBox ID="txt_fname" runat="server" Height="25px" Width="200px" ></asp:TextBox>
                        </td>
                        <td style="height: 23px"></td>
                    </tr>
                    <tr>
                        <td style="width: 347px; height: 24px;"></td>
                        <td style="width: 66px; height: 25px;">Lastname*</td>
                        <td style="width: 14px; height: 24px;">
                            <asp:TextBox ID="txt_lname" runat="server" Height="25px" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 318px; height: 24px;"></td>
                    </tr>
                    <tr>
                        <td style="width: 347px; height: 25px;">&nbsp;</td>
                        <td style="width: 66px; height: 25px;">Mi*</td>
                        <td style="width: 14px; height: 25px;">
                            <asp:TextBox ID="txt_mi" runat="server" Height="25px" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 318px; height: 25px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 347px; height: 25px;"></td>
                        <td style="width: 66px; height: 25px;">Username*</td>
                        <td style="width: 14px; height: 25px;">
                            <asp:TextBox ID="txt_username" runat="server" Height="25px" Width="200px"></asp:TextBox>
                        </td>
                        <td style="width: 318px; height: 25px;"></td>
                    </tr>
                    <tr>
                        <td style="width: 347px; height: 25px;">&nbsp;</td>
                        <td style="width: 66px; height: 25px;">&nbsp;</td>
                        <td style="width: 14px; height: 25px;">&nbsp;</td>
                        <td style="width: 318px; height: 25px;">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 347px; height: 41px;">
                            <asp:Label ID="Label1" runat="server"></asp:Label>
                        </td>
                        <td style="width: 66px; height: 41px;">
                            <asp:Button ID="Button1" runat="server" Text="Update" Width="131px" OnClick="Button1_Click"  class="btn btn-success"/>
                        </td>
                        <td style="height: 41px; width: 14px;">
                            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click1" Text="Cancel" Width="125px" class="btn btn-danger"/>
                        </td>
                        <td style="width: 318px; height: 41px;"></td>
                    </tr>
                </table>
                </div>

    </asp:Content>

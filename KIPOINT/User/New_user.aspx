<%@ Page Title="New User" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="New_user.aspx.cs" Inherits="KIPOINT.New_user" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .nav-justified{
            margin-top: 50px;
        }
    </style>

    <table class="nav-justified">
        <tr>
            <td style="width: 406px">&nbsp;</td>
            <td class="modal-sm" style="width: 277px">&nbsp;</td>
            <td style="width: 230px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px">&nbsp;</td>
            <td colspan="2" style="height: 20px">&nbsp;</td>
            <td style="height: 20px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 406px; height: 20px"></td>
            <td style="width: 277px; height: 20px">Firstname</td>
            <td style="width: 230px; height: 20px">
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="width: 406px; height: 20px"></td>
            <td style="width: 277px; height: 20px">Lastname</td>
            <td style="width: 230px; height: 20px">
                <asp:Label ID="Label2" runat="server"></asp:Label>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">Username</td>
            <td style="height: 20px; width: 230px">
                <asp:Label ID="Label3" runat="server"></asp:Label>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px">&nbsp;</td>
            <td style="height: 20px; width: 277px">&nbsp;</td>
            <td style="height: 20px; width: 230px">&nbsp;</td>
            <td style="height: 20px">&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">Secret Question*</td>
            <td style="height: 20px; width: 230px">
                <asp:DropDownList ID="secret_question" runat="server" Height="17px" Width="185px">
                    <asp:ListItem>In what city were you born?</asp:ListItem>
                    <asp:ListItem Value="What is the name of your favorite pet?"></asp:ListItem>
                    <asp:ListItem Value="What high school did you attend?"></asp:ListItem>
                    <asp:ListItem Value="What is the name of your first school?"></asp:ListItem>
                    <asp:ListItem Value="What was the make of your first car?"></asp:ListItem>
                    <asp:ListItem Value="What was your favorite food as a child?"></asp:ListItem>
                    <asp:ListItem Value="Where did you meet your spouse?"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="width: 406px">&nbsp;</td>
            <td class="modal-sm" style="width: 277px">Secret Anwser*</td>
            <td style="width: 230px">
                <asp:TextBox ID="secret_ans" runat="server" Width="185px"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 406px">&nbsp;</td>
            <td colspan="2">
                <asp:Label ID="Label4" runat="server"></asp:Label>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Next" Width="191px"  class="btn btn-success"/>
            </td>
            <td style="height: 20px; width: 230px">
                <asp:Button ID="Button2" runat="server" Text="Cancel" Width="185px" OnClick="Button2_Click" class="btn btn-danger"/>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="width: 406px">&nbsp;</td>
            <td class="modal-sm" style="width: 277px">&nbsp;</td>
            <td style="width: 230px">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">New Password*</td>
            <td style="height: 20px; width: 230px">
                <asp:TextBox ID="new_pass" runat="server" MaxLength="10" TextMode="Password" Visible="False" Width="185px"></asp:TextBox>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">Confirmation Password*</td>
            <td style="height: 20px; width: 230px">
                <asp:TextBox ID="confirm_pass" runat="server" MaxLength="10" TextMode="Password" Visible="False" Width="183px"></asp:TextBox>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td colspan="2" style="height: 20px">
                <asp:Label ID="Label5" runat="server"></asp:Label>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="width: 406px">&nbsp;</td>
            <td class="modal-sm" style="width: 277px">&nbsp;</td>
            <td style="width: 230px">
                <asp:Button ID="Button3" runat="server" Text="Submit" Visible="False" Width="191px" OnClick="Button3_Click"  class="btn btn-success" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>



</asp:Content>

<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Forget_pass.aspx.cs" Inherits="KIPOINT.Forget_pass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <style>
        .nav-justified{
            margin-top:50px;
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
            <td style="width: 277px; height: 20px">Username*</td>
            <td style="width: 230px; height: 20px">
                <asp:TextBox ID="username" runat="server" Width="185px"></asp:TextBox>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="width: 406px; height: 20px"></td>
            <td style="height: 20px" colspan="2">
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">&nbsp;</td>
            <td style="height: 20px; width: 230px">
                &nbsp;</td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">Secret Question*</td>
            <td style="height: 20px; width: 230px">
                <asp:Label ID="secret_question" runat="server"></asp:Label>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="width: 406px">&nbsp;</td>
            <td class="modal-sm" style="width: 277px">Secret Anwser*</td>
            <td style="width: 230px">
                <asp:TextBox ID="secret_ans" runat="server" TextMode="Password" Width="185px" ReadOnly="True"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 406px; height: 20px;"></td>
            <td colspan="2" style="height: 20px">
                <asp:Label ID="Label2" runat="server"></asp:Label>
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
                <asp:TextBox ID="new_pass" runat="server" MaxLength="10" TextMode="Password" Width="185px" ReadOnly="True"></asp:TextBox>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td style="height: 20px; width: 277px">Confirmation Password*</td>
            <td style="height: 20px; width: 230px">
                <asp:TextBox ID="confirm_pass" runat="server" MaxLength="10" TextMode="Password" Width="185px" ReadOnly="True"></asp:TextBox>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="height: 20px; width: 406px"></td>
            <td colspan="2" style="height: 20px">
                <asp:Label ID="Label3" runat="server"></asp:Label>
            </td>
            <td style="height: 20px"></td>
        </tr>
        <tr>
            <td style="width: 406px">&nbsp;</td>
            <td class="modal-sm" style="width: 277px">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" Width="191px"  class="btn btn-success" />
            </td>
            <td style="width: 230px">
                <asp:Button ID="Button2" runat="server" Text="Cancel" Width="185px" OnClick="Button2_Click" class="btn btn-danger" />
            </td>
            <td>&nbsp;</td>
        </tr>
    </table>

</asp:Content>

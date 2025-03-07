<%@ Page Title="" Language="C#" MasterPageFile="~/USER.master" AutoEventWireup="true" CodeFile="Blog_Details.aspx.cs" Inherits="Blog_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .banner-img {
    width: 100%;        
    height: 500px;      
    object-fit: cover;  
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="max-width-1 m-auto">
        <hr>
    </div>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
   
     <div class="container-fluid p-0">
    <img src='<%# "admin/img/" + Eval("ImagePath") %>' class="img-fluid w-100 banner-img" alt="Banner Image">
</div>



    <div class="m-auto blog-post-content max-width-2 m-auto my-2">
        <h1 class="font1"><%# Eval("BlogName") %> </h1>
        <div class="blogpost-meta">
            <div class="author-info">
                <div>
                <b>
                  <%# Eval("Author") %>
                </b>
                </div>
                <div><%# Eval("CreatedAt") %></div>
            </div>
            
        </div>
         <p class="font1"><%# Eval("Content") %></p>
         
    </div>

        </ItemTemplate>
    </asp:Repeater>
    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:Blogs %>' SelectCommand="SELECT * FROM [Blogs] WHERE ([BlogID] = @BlogID)">
        <SelectParameters>
            <asp:SessionParameter SessionField="blogid" DefaultValue="0" Name="BlogID" Type="Int32"></asp:SessionParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="max-width-1 m-auto"><hr></div>
    <div class="home-articles max-width-1 m-auto font2">
        <h2>People who read this also read</h2>
        <div class="row">
<asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
            <ItemTemplate>
                <div class="home-article">
                     <div class="home-article-img">
                         <img src="<%# ("admin/img/") + Eval("ImagePath") %>" height="200px" width="100px" alt="article">
                     </div>
                     <div class="home-article-content font1">
                         <asp:HyperLink ID="HyperLink1" runat="server" >
                         </asp:HyperLink>
                         <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("BlogID") %>'><%# Eval("BlogName") %></asp:LinkButton>
                         
                         <div> <%# Eval("Author") %></div>
                         <span><%# Eval("CreatedAt") %></span>
                     </div>
                 </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:Blogs %>' SelectCommand="SELECT * FROM [Blogs] WHERE ([BlogID] <> @BlogID)">
            <SelectParameters>
                <asp:SessionParameter SessionField="blogid" Name="BlogID" Type="Int32"></asp:SessionParameter>
            </SelectParameters>
        </asp:SqlDataSource>
        
        
        
    </div>
    </div>
</asp:Content>


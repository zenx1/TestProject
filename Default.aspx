<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <style type="text/css">
        .grid-container {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            padding: 10px;
        }

        .grid-item {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 20px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .template {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <script type="text/javascript">
            class Page {
                #ID
                #endCursor
                #loadingNext
                #hasNextPage

                constructor(ID) {
                    this.#ID = ID;
                    this.#hasNextPage = true;

                    $('.grid-container').html('');

                    this.loadMoreMovies();
                }

                #addMoviesToGridContainer(movies) {
                    for (const movie of movies) {
                        const gridItem = $('.grid-item.template').clone();

                        $('.k-card-title', gridItem).html(movie.title);
                        $('.k-card-subtitle', gridItem).html(movie.releaseDateText);
                        $('.k-card-body p', gridItem).html(movie.criticsScore.scorePercent == "" ? "-" : movie.criticsScore.scorePercent);
                        $('.k-card-image', gridItem).attr('src', movie.posterUri);
                        $('.k-card-footer', gridItem).html(movie.type);

                        $(gridItem).removeClass('template');

                        $('.grid-container').append(gridItem);
                    }
                }

                async loadMoreMovies() {
                    if (this.#loadingNext || !this.#hasNextPage) {
                        return;
                    }

                    this.#loadingNext = true;

                    var url = `Handlers/RTProxy.ashx?sort=${this.#ID}`;

                    if (this.#endCursor) {
                        url += `&endCursor=${this.#endCursor}`;
                    }

                    const response = await $.get(url);

                    this.#endCursor = response.pageInfo.endCursor;

                    this.#hasNextPage = !!this.#endCursor;

                    this.#addMoviesToGridContainer(response.grid.list);

                    this.#loadingNext = false;
                }
            }

            var currentPage = new Page('newest');

            const menuItemClicked = async (sender, args) => {
                const id = $(args.get_domEvent().target).attr('id');

                currentPage = new Page(id);
            };

            $(window).on('scroll', async () => {
                const gridContainer = $('.grid-container');

                if ($(window).scrollTop() >= gridContainer.offset().top + gridContainer.outerHeight() - window.innerHeight) {
                    currentPage.loadMoreMovies();
                }
            });
        </script>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadMenu ID="MainMenu" runat="server" Skin="MetroTouch" Style="top: 0px; left: 0px; height: 41px" Width="100%" OnClientItemClicked="menuItemClicked">
            <Items>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" Selected="True" ID="newest" Text="Newest Movies">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="popular" Text="Most Popular Movies">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="top_box_office" Text="Top Box Office Movies">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="a_z" Text="A-Z Movies">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="critic_highest" Text="Highest Rated by Critics">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="critic_lowest" Text="Lowest Rated by Critics">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="audience_highest" Text="Highest Rated by Audience">
                </telerik:RadMenuItem>
                <telerik:RadMenuItem runat="server" ClientIDMode="Static" ID="audience_lowest" Text="Lowest rated by Audience">
                </telerik:RadMenuItem>
            </Items>
        </telerik:RadMenu>

        <div class="grid-item template">
            <telerik:RadCard runat="server" Width="85%" Height="100%">
                <telerik:CardHeaderComponent runat="server">
                    <telerik:CardTitleComponent runat="server">
                    </telerik:CardTitleComponent>
                    <telerik:CardSubtitleComponent runat="server">
                    </telerik:CardSubtitleComponent>
                </telerik:CardHeaderComponent>
                <telerik:CardBodyComponent runat="server">
                    <p></p>
                    <telerik:CardImageComponent runat="server" src='#'></telerik:CardImageComponent>
                </telerik:CardBodyComponent>
                <telerik:CardFooterComponent runat="server">
                    <p></p>
                </telerik:CardFooterComponent>
            </telerik:RadCard>
        </div>

        <div class="grid-container">
           
        </div>
    </form>
</body>
</html>

using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(RicardoPalma.Startup))]
namespace RicardoPalma
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

#include "xbee-controller.h"

namespace pigeons_mission_viewer {
namespace xbee {

class XbeeController::Implementation
{
public:
    Implementation(XbeeController* _xbeeController)
        : xbeeController(_xbeeController)
    {
        //navigationController = new NavigationController(masterController);
    }

    XbeeController* xbeeController{nullptr};
    //NavigationController* navigationController{nullptr};
    //QString welcomeMessage = "This is MasterController to Major Tom";
};

XbeeController::XbeeController(QObject* parent)
    : QObject(parent)
{
    implementation.reset(new Implementation(this));
}

XbeeController::~XbeeController()
{
}

//NavigationController* MasterController::navigationController()
//{
//    return implementation->navigationController;
//}

//const QString& MasterController::welcomeMessage() const
//{
//    return implementation->welcomeMessage;
//}

}}

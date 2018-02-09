using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Description;
using System.Text;
using System.Threading.Tasks;

namespace CopRevenueGov2.Test.RTTIE227
{
    class RTTIE227_XMLServiceTests
    {
        public static ServiceHost CreateServiceHost<TServiceToHost>
            (TServiceToHost serviceToHost, Uri baseAddress, string endpointAddress)
        {
            var serviceHost = new ServiceHost(serviceToHost, new[] { baseAddress });

            serviceHost.Description.Behaviors.Find<ServiceDebugBehavior>().IncludeExceptionDetailInFaults = true;
            serviceHost.Description.Behaviors.Find<ServiceBehaviorAttribute>().InstanceContextMode 
                = InstanceContextMode.Single;

            serviceHost.AddServiceEndpoint(typeof(TServiceToHost), new BasicHttpBinding(), endpointAddress);

            return serviceHost;
        }

        //Testing Service

        [TestFixture]
        class TestService
        {
            private ServiceHost myServiceUnderTestHost;
            private ChannelFactory<IMyServiceUnderTest> myServiceUnderTestProxyFactory;
            [SetUp]
            public void SetUp()
            {
                IMyServiceUnderTest myServiceUnderTest = new MyServiceUnderTest();
                myServiceUnderTestHost = 
            CreateServiceHost<IMyServiceUnderTest>(myServiceUnderTest, new Uri("http://localhost:4961"), "http://ISDEV.city.phila.local:5555/ws/RTTIE227.service:RTTIE227WS?WSDL");
                myServiceUnderTestHost.Open();

                myServiceUnderTestProxyFactory = new 
                ChannelFactory<IMyServiceUnderTest>(new BasicHttpBinding(), new EndpointAddress("http://ISDEV.city.phila.local:5555/ws/RTTIE227.service:RTTIE227WS?WSDL"));
            }

            [TearDown]
            public void TearDown()
            {
                myServiceUnderTestProxyFactory.Close();
                myServiceUnderTestHost.Close();
            }

            [Test]
            public void SomeTest()
            {
                IMyServiceUnderTest serviceProxy = myServiceUnderTestProxyFactory.CreateChannel();

                serviceProxy.SomeMethodCall();
            }
        }

        //Testing Client

        [TestFixture]
        class TestService
        {
            private ServiceHost myMockedServiceUnderTestHost;
            private IMyServiceUnderTest myMockedServiceUnderTest;

            [SetUp]
            public void SetUp()
            {
                myMockedServiceUnderTest = Substitute.For<IMyServiceUnderTest>(); //Using nsubstitute
                myServiceUnderTestHost = CreateServiceHost<IMyServiceUnderTest>(myMockedServiceUnderTest, new Uri("http://localhost:12345"), "ServiceEndPoint");
                myServiceUnderTestHost.Open();
            }

            [TearDown]
            public void TearDown()
            {
                myServiceUnderTestHost.Close();
            }

            [Test]
            public void SomeTest()
            {
                //Create client and invoke methods that will call service
                //Will need some way of configuring the binding
                var client = new myClientUnderTest();

                client.DoWork();

                //Assert that method was called on the server
                myMockedServiceUnderTest.Recieved().SomeMethodCall();
            }
        }
    }
}

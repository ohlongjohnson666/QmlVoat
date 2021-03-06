# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.21
# 
# >> macros
# << macros

Name:       qmlreddit
Summary:    Reddit reader application
Version:    0.0.1
Release:    1
Group:      Development/Tools
License:    MIT
URL:        http://qt.nokia.com
Source0:    %{name}-%{version}.tar.gz
Source100:  qmlreddit.yaml
BuildRequires:  pkgconfig(QtCore) >= 4.7.0
BuildRequires:  pkgconfig(QtGui)


%description
Browse Reddit (popular link sharing/discussion website) in technicolor. Supports login, fetching of subscriptions, voting on links and comments. Fast UI written in QML.



%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qmake 

make %{?jobs:-j%jobs}

# >> build post
# << build post
%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake_install

# >> install post
# << install post






%files
%defattr(-,root,root,-)
/usr
# >> files
# << files



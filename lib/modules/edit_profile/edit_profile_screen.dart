import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget
{
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer <SocialCubit, SocialStates>(
      listener: (context, state){},
      builder: (context, state)
        {
          var userModel = SocialCubit.get(context).userModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;

          nameController.text = userModel!.name!;
          bioController.text = userModel.bio!;
          phoneController.text = userModel.phone!;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                defaultTextButton(
                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                    );
                  },
                  text: 'Update',
                ),
                const SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 190.0,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children:
                        [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children:
                              [
                                Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null ? NetworkImage('${userModel.cover}') : FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                                IconButton(
                                    onPressed: ()
                                    {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: const CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16.0,
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null ?  NetworkImage('${userModel.image}') : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                              IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                    Row(
                    children:
                    [
                      if (SocialCubit.get(context).profileImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                  );
                                },
                                text: 'Upload Profile',
                            ),
                            if (state is SocialUserUpdateLoadingState)
                              const SizedBox(
                                height: 8.0,
                              ),
                            if (state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      if (SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    bio: bioController.text,
                                    phone: phoneController.text,
                                  );
                                },
                                text: 'Upload Cover',
                              ),
                              if (state is SocialUserUpdateLoadingState)
                                const SizedBox(
                                height: 8.0,
                              ),
                              if (state is SocialUserUpdateLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  defaultFormField(
                      context,
                      controller: nameController,
                      type: TextInputType.name,
                      labelText: 'Name',
                      prefixIcon: IconBroken.User,
                      validate: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Name must not be Empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      context,
                      controller: bioController,
                      type: TextInputType.text,
                      labelText: 'Bio',
                      prefixIcon: IconBroken.Info_Circle,
                      validate: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Bio must not be Empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      context,
                      controller: phoneController,
                      type: TextInputType.phone,
                      labelText: 'Phone Number',
                      prefixIcon: IconBroken.Call,
                      validate: (value)
                      {
                        if (value!.isEmpty)
                        {
                          return 'Phone Number must not be Empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: MaterialButton(
                          color: Colors.red,
                          onPressed: ()
                          {
                            SocialCubit.get(context).logout(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Icon(
                                IconBroken.Logout,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),

                  ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      );
  }
}

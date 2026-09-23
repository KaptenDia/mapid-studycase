import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../themes/themes.dart';

class ImageGalleryScreen extends StatefulWidget {
  final List<String> imagesUrl;
  const ImageGalleryScreen({super.key, required this.imagesUrl});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.imagesUrl.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return PhotoView(
                      imageProvider: NetworkImage(widget.imagesUrl[index]),
                      backgroundDecoration: const BoxDecoration(
                        color: AppColors.backgroundPrimary,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 78.h,
                child: ListView.separated(
                  padding: EdgeInsets.all(8.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndex == index
                              ? AppColors.textPrimary.withAlpha(50)
                              : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.r),
                        child: Image.network(
                          widget.imagesUrl[index],
                          width: 70.h,
                          height: 78.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 4.w),
                  itemCount: widget.imagesUrl.length,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.all(6.w),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 12.h,
                left: 12.w,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 22.w, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

List <String> alHajj =['بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ يَـٰٓأَيُّهَا ٱلنَّاسُ ٱتَّقُوا۟ رَبَّكُمْ ۚ إِنَّ زَلْزَلَةَ ٱلسَّاعَةِ شَىْءٌ عَظِيمٌ', 'يَوْمَ تَرَوْنَهَا تَذْهَلُ كُلُّ مُرْضِعَةٍ عَمَّآ أَرْضَعَتْ وَتَضَعُ كُلُّ ذَاتِ حَمْلٍ حَمْلَهَا وَتَرَى ٱلنَّاسَ سُكَـٰرَىٰ وَمَا هُم بِسُكَـٰرَىٰ وَلَـٰكِنَّ عَذَابَ ٱللَّهِ شَدِيدٌ', 'وَمِنَ ٱلنَّاسِ مَن يُجَـٰدِلُ فِى ٱللَّهِ بِغَيْرِ عِلْمٍ وَيَتَّبِعُ كُلَّ شَيْطَـٰنٍ مَّرِيدٍ', 'كُتِبَ عَلَيْهِ أَنَّهُۥ مَن تَوَلَّاهُ فَأَنَّهُۥ يُضِلُّهُۥ وَيَهْدِيهِ إِلَىٰ عَذَابِ ٱلسَّعِيرِ', 'يَـٰٓأَيُّهَا ٱلنَّاسُ إِن كُنتُمْ فِى رَيْبٍ مِّنَ ٱلْبَعْثِ فَإِنَّا خَلَقْنَـٰكُم مِّن تُرَابٍ ثُمَّ مِن نُّطْفَةٍ ثُمَّ مِنْ عَلَقَةٍ ثُمَّ مِن مُّضْغَةٍ مُّخَلَّقَةٍ وَغَيْرِ مُخَلَّقَةٍ لِّنُبَيِّنَ لَكُمْ ۚ وَنُقِرُّ فِى ٱلْأَرْحَامِ مَا نَشَآءُ إِلَىٰٓ أَجَلٍ مُّسَمًّى ثُمَّ نُخْرِجُكُمْ طِفْلًا ثُمَّ لِتَبْلُغُوٓا۟ أَشُدَّكُمْ ۖ وَمِنكُم مَّن يُتَوَفَّىٰ وَمِنكُم مَّن يُرَدُّ إِلَىٰٓ أَرْذَلِ ٱلْعُمُرِ لِكَيْلَا يَعْلَمَ مِنۢ بَعْدِ عِلْمٍ شَيْـًٔا ۚ وَتَرَى ٱلْأَرْضَ هَامِدَةً فَإِذَآ أَنزَلْنَا عَلَيْهَا ٱلْمَآءَ ٱهْتَزَّتْ وَرَبَتْ وَأَنۢبَتَتْ مِن كُلِّ زَوْجٍۭ بَهِيجٍ', 'ذَٰلِكَ بِأَنَّ ٱللَّهَ هُوَ ٱلْحَقُّ وَأَنَّهُۥ يُحْىِ ٱلْمَوْتَىٰ وَأَنَّهُۥ عَلَىٰ كُلِّ شَىْءٍ قَدِيرٌ', 'وَأَنَّ ٱلسَّاعَةَ ءَاتِيَةٌ لَّا رَيْبَ فِيهَا وَأَنَّ ٱللَّهَ يَبْعَثُ مَن فِى ٱلْقُبُورِ', 'وَمِنَ ٱلنَّاسِ مَن يُجَـٰدِلُ فِى ٱللَّهِ بِغَيْرِ عِلْمٍ وَلَا هُدًى وَلَا كِتَـٰبٍ مُّنِيرٍ', 'ثَانِىَ عِطْفِهِۦ لِيُضِلَّ عَن سَبِيلِ ٱللَّهِ ۖ لَهُۥ فِى ٱلدُّنْيَا خِزْىٌ ۖ وَنُذِيقُهُۥ يَوْمَ ٱلْقِيَـٰمَةِ عَذَابَ ٱلْحَرِيقِ', 'ذَٰلِكَ بِمَا قَدَّمَتْ يَدَاكَ وَأَنَّ ٱللَّهَ لَيْسَ بِظَلَّـٰمٍ لِّلْعَبِيدِ', 'وَمِنَ ٱلنَّاسِ مَن يَعْبُدُ ٱللَّهَ عَلَىٰ حَرْفٍ ۖ فَإِنْ أَصَابَهُۥ خَيْرٌ ٱطْمَأَنَّ بِهِۦ ۖ وَإِنْ أَصَابَتْهُ فِتْنَةٌ ٱنقَلَبَ عَلَىٰ وَجْهِهِۦ خَسِرَ ٱلدُّنْيَا وَٱلْـَٔاخِرَةَ ۚ ذَٰلِكَ هُوَ ٱلْخُسْرَانُ ٱلْمُبِينُ', 'يَدْعُوا۟ مِن دُونِ ٱللَّهِ مَا لَا يَضُرُّهُۥ وَمَا لَا يَنفَعُهُۥ ۚ ذَٰلِكَ هُوَ ٱلضَّلَـٰلُ ٱلْبَعِيدُ', 'يَدْعُوا۟ لَمَن ضَرُّهُۥٓ أَقْرَبُ مِن نَّفْعِهِۦ ۚ لَبِئْسَ ٱلْمَوْلَىٰ وَلَبِئْسَ ٱلْعَشِيرُ', 'إِنَّ ٱللَّهَ يُدْخِلُ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّـٰلِحَـٰتِ جَنَّـٰتٍ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَـٰرُ ۚ إِنَّ ٱللَّهَ يَفْعَلُ مَا يُرِيدُ', 'مَن كَانَ يَظُنُّ أَن لَّن يَنصُرَهُ ٱللَّهُ فِى ٱلدُّنْيَا وَٱلْـَٔاخِرَةِ فَلْيَمْدُدْ بِسَبَبٍ إِلَى ٱلسَّمَآءِ ثُمَّ لْيَقْطَعْ فَلْيَنظُرْ هَلْ يُذْهِبَنَّ كَيْدُهُۥ مَا يَغِيظُ', 'وَكَذَٰلِكَ أَنزَلْنَـٰهُ ءَايَـٰتٍۭ بَيِّنَـٰتٍ وَأَنَّ ٱللَّهَ يَهْدِى مَن يُرِيدُ', 'إِنَّ ٱلَّذِينَ ءَامَنُوا۟ وَٱلَّذِينَ هَادُوا۟ وَٱلصَّـٰبِـِٔينَ وَٱلنَّصَـٰرَىٰ وَٱلْمَجُوسَ وَٱلَّذِينَ أَشْرَكُوٓا۟ إِنَّ ٱللَّهَ يَفْصِلُ بَيْنَهُمْ يَوْمَ ٱلْقِيَـٰمَةِ ۚ إِنَّ ٱللَّهَ عَلَىٰ كُلِّ شَىْءٍ شَهِيدٌ', 'أَلَمْ تَرَ أَنَّ ٱللَّهَ يَسْجُدُ لَهُۥ مَن فِى ٱلسَّمَـٰوَٰتِ وَمَن فِى ٱلْأَرْضِ وَٱلشَّمْسُ وَٱلْقَمَرُ وَٱلنُّجُومُ وَٱلْجِبَالُ وَٱلشَّجَرُ وَٱلدَّوَآبُّ وَكَثِيرٌ مِّنَ ٱلنَّاسِ ۖ وَكَثِيرٌ حَقَّ عَلَيْهِ ٱلْعَذَابُ ۗ وَمَن يُهِنِ ٱللَّهُ فَمَا لَهُۥ مِن مُّكْرِمٍ ۚ إِنَّ ٱللَّهَ يَفْعَلُ مَا يَشَآءُ ۩', '۞ هَـٰذَانِ خَصْمَانِ ٱخْتَصَمُوا۟ فِى رَبِّهِمْ ۖ فَٱلَّذِينَ كَفَرُوا۟ قُطِّعَتْ لَهُمْ ثِيَابٌ مِّن نَّارٍ يُصَبُّ مِن فَوْقِ رُءُوسِهِمُ ٱلْحَمِيمُ', 'يُصْهَرُ بِهِۦ مَا فِى بُطُونِهِمْ وَٱلْجُلُودُ', 'وَلَهُم مَّقَـٰمِعُ مِنْ حَدِيدٍ', 'كُلَّمَآ أَرَادُوٓا۟ أَن يَخْرُجُوا۟ مِنْهَا مِنْ غَمٍّ أُعِيدُوا۟ فِيهَا وَذُوقُوا۟ عَذَابَ ٱلْحَرِيقِ', 'إِنَّ ٱللَّهَ يُدْخِلُ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّـٰلِحَـٰتِ جَنَّـٰتٍ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَـٰرُ يُحَلَّوْنَ فِيهَا مِنْ أَسَاوِرَ مِن ذَهَبٍ وَلُؤْلُؤًا ۖ وَلِبَاسُهُمْ فِيهَا حَرِيرٌ', 'وَهُدُوٓا۟ إِلَى ٱلطَّيِّبِ مِنَ ٱلْقَوْلِ وَهُدُوٓا۟ إِلَىٰ صِرَٰطِ ٱلْحَمِيدِ', 'إِنَّ ٱلَّذِينَ كَفَرُوا۟ وَيَصُدُّونَ عَن سَبِيلِ ٱللَّهِ وَٱلْمَسْجِدِ ٱلْحَرَامِ ٱلَّذِى جَعَلْنَـٰهُ لِلنَّاسِ سَوَآءً ٱلْعَـٰكِفُ فِيهِ وَٱلْبَادِ ۚ وَمَن يُرِدْ فِيهِ بِإِلْحَادٍۭ بِظُلْمٍ نُّذِقْهُ مِنْ عَذَابٍ أَلِيمٍ', 'وَإِذْ بَوَّأْنَا لِإِبْرَٰهِيمَ مَكَانَ ٱلْبَيْتِ أَن لَّا تُشْرِكْ بِى شَيْـًٔا وَطَهِّرْ بَيْتِىَ لِلطَّآئِفِينَ وَٱلْقَآئِمِينَ وَٱلرُّكَّعِ ٱلسُّجُودِ', 'وَأَذِّن فِى ٱلنَّاسِ بِٱلْحَجِّ يَأْتُوكَ رِجَالًا وَعَلَىٰ كُلِّ ضَامِرٍ يَأْتِينَ مِن كُلِّ فَجٍّ عَمِيقٍ', 'لِّيَشْهَدُوا۟ مَنَـٰفِعَ لَهُمْ وَيَذْكُرُوا۟ ٱسْمَ ٱللَّهِ فِىٓ أَيَّامٍ مَّعْلُومَـٰتٍ عَلَىٰ مَا رَزَقَهُم مِّنۢ بَهِيمَةِ ٱلْأَنْعَـٰمِ ۖ فَكُلُوا۟ مِنْهَا وَأَطْعِمُوا۟ ٱلْبَآئِسَ ٱلْفَقِيرَ', 'ثُمَّ لْيَقْضُوا۟ تَفَثَهُمْ وَلْيُوفُوا۟ نُذُورَهُمْ وَلْيَطَّوَّفُوا۟ بِٱلْبَيْتِ ٱلْعَتِيقِ', 'ذَٰلِكَ وَمَن يُعَظِّمْ حُرُمَـٰتِ ٱللَّهِ فَهُوَ خَيْرٌ لَّهُۥ عِندَ رَبِّهِۦ ۗ وَأُحِلَّتْ لَكُمُ ٱلْأَنْعَـٰمُ إِلَّا مَا يُتْلَىٰ عَلَيْكُمْ ۖ فَٱجْتَنِبُوا۟ ٱلرِّجْسَ مِنَ ٱلْأَوْثَـٰنِ وَٱجْتَنِبُوا۟ قَوْلَ ٱلزُّورِ', 'حُنَفَآءَ لِلَّهِ غَيْرَ مُشْرِكِينَ بِهِۦ ۚ وَمَن يُشْرِكْ بِٱللَّهِ فَكَأَنَّمَا خَرَّ مِنَ ٱلسَّمَآءِ فَتَخْطَفُهُ ٱلطَّيْرُ أَوْ تَهْوِى بِهِ ٱلرِّيحُ فِى مَكَانٍ سَحِيقٍ', 'ذَٰلِكَ وَمَن يُعَظِّمْ شَعَـٰٓئِرَ ٱللَّهِ فَإِنَّهَا مِن تَقْوَى ٱلْقُلُوبِ', 'لَكُمْ فِيهَا مَنَـٰفِعُ إِلَىٰٓ أَجَلٍ مُّسَمًّى ثُمَّ مَحِلُّهَآ إِلَى ٱلْبَيْتِ ٱلْعَتِيقِ', 'وَلِكُلِّ أُمَّةٍ جَعَلْنَا مَنسَكًا لِّيَذْكُرُوا۟ ٱسْمَ ٱللَّهِ عَلَىٰ مَا رَزَقَهُم مِّنۢ بَهِيمَةِ ٱلْأَنْعَـٰمِ ۗ فَإِلَـٰهُكُمْ إِلَـٰهٌ وَٰحِدٌ فَلَهُۥٓ أَسْلِمُوا۟ ۗ وَبَشِّرِ ٱلْمُخْبِتِينَ', 'ٱلَّذِينَ إِذَا ذُكِرَ ٱللَّهُ وَجِلَتْ قُلُوبُهُمْ وَٱلصَّـٰبِرِينَ عَلَىٰ مَآ أَصَابَهُمْ وَٱلْمُقِيمِى ٱلصَّلَوٰةِ وَمِمَّا رَزَقْنَـٰهُمْ يُنفِقُونَ', 'وَٱلْبُدْنَ جَعَلْنَـٰهَا لَكُم مِّن شَعَـٰٓئِرِ ٱللَّهِ لَكُمْ فِيهَا خَيْرٌ ۖ فَٱذْكُرُوا۟ ٱسْمَ ٱللَّهِ عَلَيْهَا صَوَآفَّ ۖ فَإِذَا وَجَبَتْ جُنُوبُهَا فَكُلُوا۟ مِنْهَا وَأَطْعِمُوا۟ ٱلْقَانِعَ وَٱلْمُعْتَرَّ ۚ كَذَٰلِكَ سَخَّرْنَـٰهَا لَكُمْ لَعَلَّكُمْ تَشْكُرُونَ', 'لَن يَنَالَ ٱللَّهَ لُحُومُهَا وَلَا دِمَآؤُهَا وَلَـٰكِن يَنَالُهُ ٱلتَّقْوَىٰ مِنكُمْ ۚ كَذَٰلِكَ سَخَّرَهَا لَكُمْ لِتُكَبِّرُوا۟ ٱللَّهَ عَلَىٰ مَا هَدَىٰكُمْ ۗ وَبَشِّرِ ٱلْمُحْسِنِينَ', '۞ إِنَّ ٱللَّهَ يُدَٰفِعُ عَنِ ٱلَّذِينَ ءَامَنُوٓا۟ ۗ إِنَّ ٱللَّهَ لَا يُحِبُّ كُلَّ خَوَّانٍ كَفُورٍ', 'أُذِنَ لِلَّذِينَ يُقَـٰتَلُونَ بِأَنَّهُمْ ظُلِمُوا۟ ۚ وَإِنَّ ٱللَّهَ عَلَىٰ نَصْرِهِمْ لَقَدِيرٌ', 'ٱلَّذِينَ أُخْرِجُوا۟ مِن دِيَـٰرِهِم بِغَيْرِ حَقٍّ إِلَّآ أَن يَقُولُوا۟ رَبُّنَا ٱللَّهُ ۗ وَلَوْلَا دَفْعُ ٱللَّهِ ٱلنَّاسَ بَعْضَهُم بِبَعْضٍ لَّهُدِّمَتْ صَوَٰمِعُ وَبِيَعٌ وَصَلَوَٰتٌ وَمَسَـٰجِدُ يُذْكَرُ فِيهَا ٱسْمُ ٱللَّهِ كَثِيرًا ۗ وَلَيَنصُرَنَّ ٱللَّهُ مَن يَنصُرُهُۥٓ ۗ إِنَّ ٱللَّهَ لَقَوِىٌّ عَزِيزٌ', 'ٱلَّذِينَ إِن مَّكَّنَّـٰهُمْ فِى ٱلْأَرْضِ أَقَامُوا۟ ٱلصَّلَوٰةَ وَءَاتَوُا۟ ٱلزَّكَوٰةَ وَأَمَرُوا۟ بِٱلْمَعْرُوفِ وَنَهَوْا۟ عَنِ ٱلْمُنكَرِ ۗ وَلِلَّهِ عَـٰقِبَةُ ٱلْأُمُورِ', 'وَإِن يُكَذِّبُوكَ فَقَدْ كَذَّبَتْ قَبْلَهُمْ قَوْمُ نُوحٍ وَعَادٌ وَثَمُودُ', 'وَقَوْمُ إِبْرَٰهِيمَ وَقَوْمُ لُوطٍ', 'وَأَصْحَـٰبُ مَدْيَنَ ۖ وَكُذِّبَ مُوسَىٰ فَأَمْلَيْتُ لِلْكَـٰفِرِينَ ثُمَّ أَخَذْتُهُمْ ۖ فَكَيْفَ كَانَ نَكِيرِ', 'فَكَأَيِّن مِّن قَرْيَةٍ أَهْلَكْنَـٰهَا وَهِىَ ظَالِمَةٌ فَهِىَ خَاوِيَةٌ عَلَىٰ عُرُوشِهَا وَبِئْرٍ مُّعَطَّلَةٍ وَقَصْرٍ مَّشِيدٍ', 'أَفَلَمْ يَسِيرُوا۟ فِى ٱلْأَرْضِ فَتَكُونَ لَهُمْ قُلُوبٌ يَعْقِلُونَ بِهَآ أَوْ ءَاذَانٌ يَسْمَعُونَ بِهَا ۖ فَإِنَّهَا لَا تَعْمَى ٱلْأَبْصَـٰرُ وَلَـٰكِن تَعْمَى ٱلْقُلُوبُ ٱلَّتِى فِى ٱلصُّدُورِ', 'وَيَسْتَعْجِلُونَكَ بِٱلْعَذَابِ وَلَن يُخْلِفَ ٱللَّهُ وَعْدَهُۥ ۚ وَإِنَّ يَوْمًا عِندَ رَبِّكَ كَأَلْفِ سَنَةٍ مِّمَّا تَعُدُّونَ', 'وَكَأَيِّن مِّن قَرْيَةٍ أَمْلَيْتُ لَهَا وَهِىَ ظَالِمَةٌ ثُمَّ أَخَذْتُهَا وَإِلَىَّ ٱلْمَصِيرُ', 'قُلْ يَـٰٓأَيُّهَا ٱلنَّاسُ إِنَّمَآ أَنَا۠ لَكُمْ نَذِيرٌ مُّبِينٌ', 'فَٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّـٰلِحَـٰتِ لَهُم مَّغْفِرَةٌ وَرِزْقٌ كَرِيمٌ', 'وَٱلَّذِينَ سَعَوْا۟ فِىٓ ءَايَـٰتِنَا مُعَـٰجِزِينَ أُو۟لَـٰٓئِكَ أَصْحَـٰبُ ٱلْجَحِيمِ', 'وَمَآ أَرْسَلْنَا مِن قَبْلِكَ مِن رَّسُولٍ وَلَا نَبِىٍّ إِلَّآ إِذَا تَمَنَّىٰٓ أَلْقَى ٱلشَّيْطَـٰنُ فِىٓ أُمْنِيَّتِهِۦ فَيَنسَخُ ٱللَّهُ مَا يُلْقِى ٱلشَّيْطَـٰنُ ثُمَّ يُحْكِمُ ٱللَّهُ ءَايَـٰتِهِۦ ۗ وَٱللَّهُ عَلِيمٌ حَكِيمٌ', 'لِّيَجْعَلَ مَا يُلْقِى ٱلشَّيْطَـٰنُ فِتْنَةً لِّلَّذِينَ فِى قُلُوبِهِم مَّرَضٌ وَٱلْقَاسِيَةِ قُلُوبُهُمْ ۗ وَإِنَّ ٱلظَّـٰلِمِينَ لَفِى شِقَاقٍۭ بَعِيدٍ', 'وَلِيَعْلَمَ ٱلَّذِينَ أُوتُوا۟ ٱلْعِلْمَ أَنَّهُ ٱلْحَقُّ مِن رَّبِّكَ فَيُؤْمِنُوا۟ بِهِۦ فَتُخْبِتَ لَهُۥ قُلُوبُهُمْ ۗ وَإِنَّ ٱللَّهَ لَهَادِ ٱلَّذِينَ ءَامَنُوٓا۟ إِلَىٰ صِرَٰطٍ مُّسْتَقِيمٍ', 'وَلَا يَزَالُ ٱلَّذِينَ كَفَرُوا۟ فِى مِرْيَةٍ مِّنْهُ حَتَّىٰ تَأْتِيَهُمُ ٱلسَّاعَةُ بَغْتَةً أَوْ يَأْتِيَهُمْ عَذَابُ يَوْمٍ عَقِيمٍ', 'ٱلْمُلْكُ يَوْمَئِذٍ لِّلَّهِ يَحْكُمُ بَيْنَهُمْ ۚ فَٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّـٰلِحَـٰتِ فِى جَنَّـٰتِ ٱلنَّعِيمِ', 'وَٱلَّذِينَ كَفَرُوا۟ وَكَذَّبُوا۟ بِـَٔايَـٰتِنَا فَأُو۟لَـٰٓئِكَ لَهُمْ عَذَابٌ مُّهِينٌ', 'وَٱلَّذِينَ هَاجَرُوا۟ فِى سَبِيلِ ٱللَّهِ ثُمَّ قُتِلُوٓا۟ أَوْ مَاتُوا۟ لَيَرْزُقَنَّهُمُ ٱللَّهُ رِزْقًا حَسَنًا ۚ وَإِنَّ ٱللَّهَ لَهُوَ خَيْرُ ٱلرَّٰزِقِينَ', 'لَيُدْخِلَنَّهُم مُّدْخَلًا يَرْضَوْنَهُۥ ۗ وَإِنَّ ٱللَّهَ لَعَلِيمٌ حَلِيمٌ', '۞ ذَٰلِكَ وَمَنْ عَاقَبَ بِمِثْلِ مَا عُوقِبَ بِهِۦ ثُمَّ بُغِىَ عَلَيْهِ لَيَنصُرَنَّهُ ٱللَّهُ ۗ إِنَّ ٱللَّهَ لَعَفُوٌّ غَفُورٌ', 'ذَٰلِكَ بِأَنَّ ٱللَّهَ يُولِجُ ٱلَّيْلَ فِى ٱلنَّهَارِ وَيُولِجُ ٱلنَّهَارَ فِى ٱلَّيْلِ وَأَنَّ ٱللَّهَ سَمِيعٌۢ بَصِيرٌ', 'ذَٰلِكَ بِأَنَّ ٱللَّهَ هُوَ ٱلْحَقُّ وَأَنَّ مَا يَدْعُونَ مِن دُونِهِۦ هُوَ ٱلْبَـٰطِلُ وَأَنَّ ٱللَّهَ هُوَ ٱلْعَلِىُّ ٱلْكَبِيرُ', 'أَلَمْ تَرَ أَنَّ ٱللَّهَ أَنزَلَ مِنَ ٱلسَّمَآءِ مَآءً فَتُصْبِحُ ٱلْأَرْضُ مُخْضَرَّةً ۗ إِنَّ ٱللَّهَ لَطِيفٌ خَبِيرٌ', 'لَّهُۥ مَا فِى ٱلسَّمَـٰوَٰتِ وَمَا فِى ٱلْأَرْضِ ۗ وَإِنَّ ٱللَّهَ لَهُوَ ٱلْغَنِىُّ ٱلْحَمِيدُ', 'أَلَمْ تَرَ أَنَّ ٱللَّهَ سَخَّرَ لَكُم مَّا فِى ٱلْأَرْضِ وَٱلْفُلْكَ تَجْرِى فِى ٱلْبَحْرِ بِأَمْرِهِۦ وَيُمْسِكُ ٱلسَّمَآءَ أَن تَقَعَ عَلَى ٱلْأَرْضِ إِلَّا بِإِذْنِهِۦٓ ۗ إِنَّ ٱللَّهَ بِٱلنَّاسِ لَرَءُوفٌ رَّحِيمٌ', 'وَهُوَ ٱلَّذِىٓ أَحْيَاكُمْ ثُمَّ يُمِيتُكُمْ ثُمَّ يُحْيِيكُمْ ۗ إِنَّ ٱلْإِنسَـٰنَ لَكَفُورٌ', 'لِّكُلِّ أُمَّةٍ جَعَلْنَا مَنسَكًا هُمْ نَاسِكُوهُ ۖ فَلَا يُنَـٰزِعُنَّكَ فِى ٱلْأَمْرِ ۚ وَٱدْعُ إِلَىٰ رَبِّكَ ۖ إِنَّكَ لَعَلَىٰ هُدًى مُّسْتَقِيمٍ', 'وَإِن جَـٰدَلُوكَ فَقُلِ ٱللَّهُ أَعْلَمُ بِمَا تَعْمَلُونَ', 'ٱللَّهُ يَحْكُمُ بَيْنَكُمْ يَوْمَ ٱلْقِيَـٰمَةِ فِيمَا كُنتُمْ فِيهِ تَخْتَلِفُونَ', 'أَلَمْ تَعْلَمْ أَنَّ ٱللَّهَ يَعْلَمُ مَا فِى ٱلسَّمَآءِ وَٱلْأَرْضِ ۗ إِنَّ ذَٰلِكَ فِى كِتَـٰبٍ ۚ إِنَّ ذَٰلِكَ عَلَى ٱللَّهِ يَسِيرٌ', 'وَيَعْبُدُونَ مِن دُونِ ٱللَّهِ مَا لَمْ يُنَزِّلْ بِهِۦ سُلْطَـٰنًا وَمَا لَيْسَ لَهُم بِهِۦ عِلْمٌ ۗ وَمَا لِلظَّـٰلِمِينَ مِن نَّصِيرٍ', 'وَإِذَا تُتْلَىٰ عَلَيْهِمْ ءَايَـٰتُنَا بَيِّنَـٰتٍ تَعْرِفُ فِى وُجُوهِ ٱلَّذِينَ كَفَرُوا۟ ٱلْمُنكَرَ ۖ يَكَادُونَ يَسْطُونَ بِٱلَّذِينَ يَتْلُونَ عَلَيْهِمْ ءَايَـٰتِنَا ۗ قُلْ أَفَأُنَبِّئُكُم بِشَرٍّ مِّن ذَٰلِكُمُ ۗ ٱلنَّارُ وَعَدَهَا ٱللَّهُ ٱلَّذِينَ كَفَرُوا۟ ۖ وَبِئْسَ ٱلْمَصِيرُ', 'يَـٰٓأَيُّهَا ٱلنَّاسُ ضُرِبَ مَثَلٌ فَٱسْتَمِعُوا۟ لَهُۥٓ ۚ إِنَّ ٱلَّذِينَ تَدْعُونَ مِن دُونِ ٱللَّهِ لَن يَخْلُقُوا۟ ذُبَابًا وَلَوِ ٱجْتَمَعُوا۟ لَهُۥ ۖ وَإِن يَسْلُبْهُمُ ٱلذُّبَابُ شَيْـًٔا لَّا يَسْتَنقِذُوهُ مِنْهُ ۚ ضَعُفَ ٱلطَّالِبُ وَٱلْمَطْلُوبُ', 'مَا قَدَرُوا۟ ٱللَّهَ حَقَّ قَدْرِهِۦٓ ۗ إِنَّ ٱللَّهَ لَقَوِىٌّ عَزِيزٌ', 'ٱللَّهُ يَصْطَفِى مِنَ ٱلْمَلَـٰٓئِكَةِ رُسُلًا وَمِنَ ٱلنَّاسِ ۚ إِنَّ ٱللَّهَ سَمِيعٌۢ بَصِيرٌ', 'يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۗ وَإِلَى ٱللَّهِ تُرْجَعُ ٱلْأُمُورُ', 'يَـٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ ٱرْكَعُوا۟ وَٱسْجُدُوا۟ وَٱعْبُدُوا۟ رَبَّكُمْ وَٱفْعَلُوا۟ ٱلْخَيْرَ لَعَلَّكُمْ تُفْلِحُونَ ۩', 'وَجَـٰهِدُوا۟ فِى ٱللَّهِ حَقَّ جِهَادِهِۦ ۚ هُوَ ٱجْتَبَىٰكُمْ وَمَا جَعَلَ عَلَيْكُمْ فِى ٱلدِّينِ مِنْ حَرَجٍ ۚ مِّلَّةَ أَبِيكُمْ إِبْرَٰهِيمَ ۚ هُوَ سَمَّىٰكُمُ ٱلْمُسْلِمِينَ مِن قَبْلُ وَفِى هَـٰذَا لِيَكُونَ ٱلرَّسُولُ شَهِيدًا عَلَيْكُمْ وَتَكُونُوا۟ شُهَدَآءَ عَلَى ٱلنَّاسِ ۚ فَأَقِيمُوا۟ ٱلصَّلَوٰةَ وَءَاتُوا۟ ٱلزَّكَوٰةَ وَٱعْتَصِمُوا۟ بِٱللَّهِ هُوَ مَوْلَىٰكُمْ ۖ فَنِعْمَ ٱلْمَوْلَىٰ وَنِعْمَ ٱلنَّصِيرُ'];